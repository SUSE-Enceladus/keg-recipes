# Leave the ephemeral disk handling to cloud-init
sed -i -e 's/ResourceDisk.Format=y/ResourceDisk.Format=n/' \
    /etc/waagent.conf
