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

if [ ! -e /etc/login.defs.d ]; then
    # login_defs rules are broken on systems that do not support /etc/login.defs.d
    # (see https://github.com/ComplianceAsCode/content/issues/15169)
    # Disable in build and in image until upstream fix is available.
    rules_to_disable="xccdf_org.ssgproject.content_rule_.*login_defs"

    # some cipher rules are broken and upstream fix is not in v0.1.82 yet
    # 15 SP5 is currently the only distro without a custom package that
    # already contains the fix, and also the last SP to use login.defs.d
    # so we piggyback on that check to disable those rules as well for now
    rules_to_disable="$rules_to_disable
xccdf_org.ssgproject.content_rule_sshd_use_approved_ciphers
xccdf_org.ssgproject.content_rule_sshd_use_approved_ciphers_ordered_stig
xccdf_org.ssgproject.content_rule_sshd_use_approved_macs
xccdf_org.ssgproject.content_rule_sshd_use_approved_macs_ordered_stig"

    for rule in $rules_to_disable ; do
       sed -i -e "/$rule/ s/selected=\"true\"/selected=\"false\"/" $ssg_file
    done
fi

for rule in $rules_to_skip ; do
    echo "skip hardening rule $rule"
    sed_args="$sed_args -e '/$rule/ s/selected=\\\"true\\\"/selected=\\\"false\\\"/'"
done
eval sed $sed_args $ssg_file > $ssg_file_build
# END SCAP hardening workarounds
