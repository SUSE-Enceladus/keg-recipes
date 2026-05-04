# run sap image hardening script
ssg_file="/usr/share/xml/scap/ssg/content/ssg-sle15-ds.xml"

echo "run oscap --profile pcs-hardening-sap"
oscap xccdf eval --remediate --profile pcs-hardening-sap $ssg_file || {
    echo "!!!FAILED: --profile pcs-hardening-sap"
    /bin/false
}
