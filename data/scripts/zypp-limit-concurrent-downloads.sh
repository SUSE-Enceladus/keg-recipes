# limit number of concurrent connections to 1
if [ -f /etc/zypp/zypp.conf ]; then
    sed -i -e 's/^[# ]*download.max_concurrent_connections.*/download.max_concurrent_connections = 1/' /etc/zypp/zypp.conf
else
    echo "download.max_concurrent_connections = 1" > /etc/zypp/zypp.conf.d/40_max_connections.conf
fi
