# run image hardening script
echo "run oscap --profile pcs-hardening"
oscap xccdf eval --remediate --profile pcs-hardening /usr/share/xml/scap/ssg/content/ssg-sle15-ds.xml || {
    echo "!!!FAILED: --profile pcs-hardening"
    /bin/false
}
