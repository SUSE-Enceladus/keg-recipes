# No Xen based instance types for ARM, no need for custom config
if [ "`uname -m`" = "aarch64" ]; then
    rm -f /etc/dracut.conf.d/07-*.conf
fi
