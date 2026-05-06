# run image hardening script
echo "run oscap --profile pcs-hardening-chost"
oscap xccdf eval --remediate --profile pcs-hardening-chost /usr/share/xml/scap/ssg/content/ssg-sle15-ds.xml || {
    echo "!!!FAILED: --profile pcs-hardening-chost"
    /bin/false
}
