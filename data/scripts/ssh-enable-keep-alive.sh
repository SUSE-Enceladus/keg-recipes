test -f /etc/ssh/sshd_config || cp /usr/etc/ssh/sshd_config /etc/ssh/
sed -i -e 's/#ClientAliveInterval 0/ClientAliveInterval 180/' \
    /etc/ssh/sshd_config
