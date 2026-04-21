# NOTE for disabled rules:
#
# Rules that need running systemd do not work in chroot, disable
# them until there is an upstream solution.
#
# Rule mount_option_dev_shm_noexec checks /proc/mounts which does not
# make sense in build env.
#
# Disable smart card rules, does not make sense in the cloud.
#
# Disable any potential sysctl rules, they do not work properly in chroot.

rules_to_disable="\
xccdf_org.ssgproject.content_rule_mount_option_dev_shm_noexec
xccdf_org.ssgproject.content_rule_aide_periodic_checking_systemd_timer
xccdf_org.ssgproject.content_rule_install_smartcard_packages
xccdf_org.ssgproject.content_rule_smartcard_configure_ca
xccdf_org.ssgproject.content_rule_smartcard_configure_cert_checking
xccdf_org.ssgproject.content_rule_.*sysctl"

ssg_file="/usr/share/xml/scap/ssg/content/ssg-sle15-ds.xml"

for rule in $rules_to_disable ; do
    echo "disable hardening rule $rule"
    sed -i -e "/$rule/ s/selected=\"true\"/selected=\"false\"/" $ssg_file
done

# create empty /etc/security/opasswd file, otherwise mitigation for
# xccdf_org.ssgproject.content_rule_file_etc_security_opasswd will fail
touch /etc/security/opasswd
chmod 600 /etc/security/opasswd
