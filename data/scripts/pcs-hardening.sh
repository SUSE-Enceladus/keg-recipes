# run image hardening script
echo "run oscap --profile pcs-hardening"
oscap xccdf eval --remediate --profile pcs-hardening $ssg_file_build || {
    echo "!!!FAILED: --profile pcs-hardening"
    /bin/false
}
