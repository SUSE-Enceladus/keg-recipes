# Container runtime config
# Note requires jq in the image
jq  '. + {"storage-driver": "overlay2"}' < /etc/docker/daemon.json >& /etc/docker/daemon.json.new
mv /etc/docker/daemon.json.new /etc/docker/daemon.json
# We also would like to disable certain plugins but that does not appear to be
# possibe through the config.json file. We'd like to have
# disabled_plugins = ["cri", "aufs", "btrfs", "zfs"]
# in /var/run/docker/containerd/containerd.toml
