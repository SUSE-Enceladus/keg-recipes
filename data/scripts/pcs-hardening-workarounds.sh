# NOTE for disabled rules:
#
# rules that need running systemd do not work in chroot, disable
# them until there is an upstream solution.
#
# rule pam_disable_automatic_configuration uses a bash input redirection
# type that required /proc which is not availble in kiwi's create step.
#
# file_permissions_backup_etc_shadow remediation is pointless, useradd
# creates new backup with standard permissions
#
# permissions_local_var_log requires files in /var/log to be not world
# readable, which is hard to enforce.
#
# xccdf_org.ssgproject.content_rule_accounts_users_home_files_permissions
# requires all files in user home trees to restrict access. Not enforcable.
#
# disable any potential sysctl rules, they do not work properly in chroot.
#
# disable the following rules proactively, as they were recently added
# to profile upstream and will break once package is updated
#
# accounts_users_home_files_permissions
# mount_option_dev_shm_noexec
# permissions_local_var_log

rules_to_disable="\
xccdf_org.ssgproject.content_rule_ensure_logrotate_activated
xccdf_org.ssgproject.content_rule_service_firewalld_enabled
xccdf_org.ssgproject.content_rule_pam_disable_automatic_configuration
xccdf_org.ssgproject.content_rule_file_permissions_backup_etc_shadow
xccdf_org.ssgproject.content_rule_accounts_users_home_files_permissions
xccdf_org.ssgproject.content_rule_mount_option_dev_shm_noexec
xccdf_org.ssgproject.content_rule_permissions_local_var_log
xccdf_org.ssgproject.content_rule_aide_periodic_checking_systemd_timer
xccdf_org.ssgproject.content_rule_.*sysctl"

ssg_file="/usr/share/xml/scap/ssg/content/ssg-sle15-ds.xml"

for rule in $rules_to_disable ; do
    echo "disable hardening rule $rule"
    sed -i -e "/$rule/ s/selected=\"true\"/selected=\"false\"/" $ssg_file
done

# run pam_disable_automatic_configuration remediation directly, to
# mitigate disabling of the rule
find /etc/pam.d/ -type l -iname "common-*" -print0 | \
while IFS= read -r -d '' link; do
    target=$(readlink -f "$link")
    cp -p --remove-destination "$target" "$link"
done
