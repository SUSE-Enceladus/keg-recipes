# Generate all supported SSH host key types
sed -i -e 's/SshHostKeyPairType=rsa/SshHostKeyPairType=auto/' \
    /etc/waagent.conf
