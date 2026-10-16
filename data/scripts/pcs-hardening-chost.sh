# rule service_kdump_disabled is only happy if kdump is masked. Disabled
# is not enough.
systemctl mask kdump.service || true

# run image hardening script
echo "run oscap --profile pcs-hardening-chost"
oscap xccdf eval --remediate --profile pcs-hardening-chost $ssg_file_build || {
    echo "!!!FAILED: --profile pcs-hardening-chost"
    /bin/false
}
