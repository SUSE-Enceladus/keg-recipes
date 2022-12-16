# Disable agent auto-update
sed -i -e 's/AutoUpdate.Enabled=y/AutoUpdate.Enabled=n/' \
    /etc/waagent.conf
