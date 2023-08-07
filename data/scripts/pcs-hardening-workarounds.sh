# NOTE: rules that need running systemd do not work in chroot, disable
# them until there is an upstream solution.
# NOTE: rule pam_disable_automatic_configuration uses a bash input redirection
# type that required /proc which is not availble in kiwi's create step.
rules_to_disable="\
xccdf_org.ssgproject.content_rule_ensure_logrotate_activated
xccdf_org.ssgproject.content_rule_service_firewalld_enabled
xccdf_org.ssgproject.content_rule_pam_disable_automatic_configuration"
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
