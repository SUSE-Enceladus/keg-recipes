# Disable agent auto-update
sed -i -e 's/AutoUpdate.Enabled=y/AutoUpdate.Enabled=n/' \
    /etc/waagent.conf
sed -i -r -e 's/(#\s*)?AutoUpdate.UpdateToLatestVersion=y/AutoUpdate.UpdateToLatestVersion=n/' \
    /etc/waagent.conf
