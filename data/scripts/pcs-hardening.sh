# run image hardening script
echo "run oscap --profile pcs-hardening"
oscap xccdf eval --remediate --profile pcs-hardening $ssg_file_build || {
    echo "!!!FAILED: --profile pcs-hardening"
    /bin/false
}
# One of the rules changes permissions of /etc/ssh/sshd_config which
# breaks file_permissions_sshd_config after it all ready ran. Run it again.
oscap xccdf eval --remediate --rule xccdf_org.ssgproject.content_rule_file_permissions_sshd_config $ssg_file_build || /bin/false
