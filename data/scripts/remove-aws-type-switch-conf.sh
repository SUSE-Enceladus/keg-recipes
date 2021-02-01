# No Xen based instance types for ARM, no need for custom config
if [ "$arch" = "aarch64" ]; then
    rm -f /etc/dracut.conf.d/07-aws-type-switch.conf
fi
