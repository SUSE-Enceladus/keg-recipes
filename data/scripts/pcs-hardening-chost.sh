# rule use_pam_wheel_for_su expects pam_wheel to be in /etc/pam.d/su as comment
grep -q pam_wheel /etc/pam.d/su || \
    echo "auth      required    pam_wheel.so use_uid" >> /etc/pam.d/su

# run image hardening script
echo "run oscap --profile pcs-hardening-chost"
oscap xccdf eval --remediate --profile pcs-hardening-chost $ssg_file_build || {
    echo "!!!FAILED: --profile pcs-hardening-chost"
    /bin/false
}
