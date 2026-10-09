echo "run oscap --profile pcs-hardening-sap"
oscap xccdf eval --remediate --profile pcs-hardening-sap $ssg_file_build || {
    echo "!!!FAILED: --profile pcs-hardening-sap"
    /bin/false
}
