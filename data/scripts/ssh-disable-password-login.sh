# Disable password based login via ssh
test -f /etc/ssh/sshd_config || cp /usr/etc/ssh/sshd_config /etc/ssh/
sed -i -e 's/#PasswordAuthentication yes/PasswordAuthentication no/' \
    /etc/ssh/sshd_config
