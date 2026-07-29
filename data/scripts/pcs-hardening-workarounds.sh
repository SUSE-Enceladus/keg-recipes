# NOTE for disabled rules:
#
# Rules that need running systemd do not work in chroot, disable
# them until there is an upstream solution.
#
# Rule mount_option_dev_shm_noexec checks /proc/mounts which does not
# make sense in build env.
#
# Disable any potential sysctl rules, they do not work properly in chroot.
#
# Temporarily disable broken sshd cipher/mac rules
# (https://github.com/ComplianceAsCode/content/issues/14926)

rules_to_disable="\
xccdf_org.ssgproject.content_rule_mount_option_dev_shm_noexec
xccdf_org.ssgproject.content_rule_aide_periodic_checking_systemd_timer
xccdf_org.ssgproject.content_rule_service_kdump_disabled
xccdf_org.ssgproject.content_rule_sshd_use_approved_ciphers
xccdf_org.ssgproject.content_rule_sshd_use_approved_ciphers_ordered_stig
xccdf_org.ssgproject.content_rule_sshd_use_approved_macs
xccdf_org.ssgproject.content_rule_sshd_use_approved_macs_ordered_stig
xccdf_org.ssgproject.content_rule_.*sysctl"

ssg_file="/usr/share/xml/scap/ssg/content/ssg-sle15-ds.xml"
ssg_file_build="/tmp/ssg-sle15-ds.xml"

for rule in $rules_to_disable ; do
    echo "disable hardening rule $rule"
    sed_args="$sed_args -e '/$rule/ s/selected=\\\"true\\\"/selected=\\\"false\\\"/'"
done
eval sed $sed_args $ssg_file > $ssg_file_build

# create empty /etc/security/opasswd file, otherwise mitigation for
# xccdf_org.ssgproject.content_rule_file_etc_security_opasswd will fail
touch /etc/security/opasswd
chmod 600 /etc/security/opasswd
