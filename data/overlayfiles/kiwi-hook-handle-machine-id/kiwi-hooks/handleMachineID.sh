# remove any existing machine IDs
rm -f /etc/machine-id
rm -f /var/lib/dbus/machine-id
# generate DBUS machine ID
dbus-uuidgen --ensure
# if on systemd, run systemd-machine-id-setup to init /etc/machine_id from dbus
test -x /usr/bin/systemd-machine-id-setup && /usr/bin/systemd-machine-id-setup
