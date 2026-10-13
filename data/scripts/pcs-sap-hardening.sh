echo "run oscap --profile pcs-hardening-sap"
oscap xccdf eval --remediate --profile pcs-hardening-sap $ssg_file_build || {
    echo "!!!FAILED: --profile pcs-hardening-sap"
    /bin/false
}
# One of the rules changes permissions of /etc/ssh/sshd_config which
# breaks file_permissions_sshd_config after it all ready ran. Run it again.
oscap xccdf eval --remediate --rule xccdf_org.ssgproject.content_rule_file_permissions_sshd_config $ssg_file_build || /bin/false
