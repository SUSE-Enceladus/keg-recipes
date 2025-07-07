# limit number of concurrent connections to 1
sed -i -e 's/^[# ]*download.max_concurrent_connections.*/download.max_concurrent_connections = 1/' /etc/zypp/zypp.conf
