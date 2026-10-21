# BEGIN SCAP hardening workarounds
sle_version=$(sed -r -n -e 's/(VERSION_ID=")([0-9]*)(\..*)/\2/p' /etc/os-release)
ssg_file=/usr/share/xml/scap/ssg/content/ssg-sle${sle_version}-ds.xml
ssg_file_build="/tmp/ssg-ds.xml"

# Rules that do not work in build root (e.g. systemd related) that we do still
# want in the image. Remediation (if necessary) needs to be implemented
# through other means, but keep them enabled for the live system.
rules_to_skip="\
xccdf_org.ssgproject.content_rule_aide_periodic_checking_systemd_timer
xccdf_org.ssgproject.content_rule_service_kdump_disabled
xccdf_org.ssgproject.content_rule_.*sysctl"

# Some sshd cipher rules are broken and upstream fix is not in v0.1.82 yet. To
# be dropped once fixed package is available.
#
# permissions_local_var_log
# Various tools write log files with looser permissions than the rule
# requires at instant initialization. Cannot be enforce by rule.
#
# audit_rules_time_settimeofday audit_rules_time_stime
# Those do exactly the same as audit_rules_time_adjtimex, causing duplicate
# rules (bsc#1250320)
rules_to_disable="\
xccdf_org.ssgproject.content_rule_sshd_use_approved_ciphers
xccdf_org.ssgproject.content_rule_sshd_use_approved_ciphers_ordered_stig
xccdf_org.ssgproject.content_rule_sshd_use_approved_macs
xccdf_org.ssgproject.content_rule_sshd_use_approved_macs_ordered_stig
xccdf_org.ssgproject.content_rule_permissions_local_var_log
xccdf_org.ssgproject.content_rule_audit_rules_time_settimeofday
xccdf_org.ssgproject.content_rule_audit_rules_time_stime"

if [ ! -e /etc/login.defs.d ]; then
    # login_defs rules are broken on systems that do not support /etc/login.defs.d
    # (see https://github.com/ComplianceAsCode/content/issues/15169)
    # Disable in build and in image until upstream fix is available.
    rules_to_disable="$rules_to_disable xccdf_org.ssgproject.content_rule_.*login_?defs"

    # Distributions that thad /etc/login.defs had loose default permissions of
    # new home directories. Mitigation of rule
    # file_permissions_home_directories only fixes home dirs but when new homes
    # are created with default permissions (as is the case during instance
    # initialization) this rule will fail evalution.
    sed -i -r -e 's/^#?HOME_MODE.*/HOME_MODE 0700/' /etc/login.defs
fi

# Rule accounts_users_home_files_permissions requires all files in homes
# to be at least 0750 or stricter. Remove any permissions for other from
# /etc/skel files so new home directories comply. (Note: /usr/etc/skel in
# SLES 16 is compliant, no mitigation necessary.)
chmod -R o-rwx /etc/skel

for rule in $rules_to_disable ; do
   sed -i -r -e "/$rule/ s/selected=\"true\"/selected=\"false\"/" $ssg_file
done

for rule in $rules_to_skip ; do
    echo "skip hardening rule $rule"
    sed_args="$sed_args -e '/$rule/ s/selected=\\\"true\\\"/selected=\\\"false\\\"/'"
done
eval sed $sed_args $ssg_file > $ssg_file_build
# END SCAP hardening workarounds
