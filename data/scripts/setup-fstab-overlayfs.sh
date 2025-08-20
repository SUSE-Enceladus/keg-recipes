cat >/etc/fstab.script <<EOF
#!/bin/sh
# The %post script can't edit /etc/fstab sys due to https://github.com/OSInside/kiwi/issues/945
# so use the kiwi custom hack
set -eux
/usr/sbin/setup-fstab-for-overlayfs
# If /var is on a different partition than /...
if [ "$(findmnt -snT / -o SOURCE)" != "$(findmnt -snT /var -o SOURCE)" ]; then
  # ... set options for autoexpanding /var
  gawk -i inplace '$2 == "/var" { $4 = $4",x-growpart.grow,x-systemd.growfs" } { print $0 }' /etc/fstab
fi
EOF
chmod a+x /etc/fstab.script
