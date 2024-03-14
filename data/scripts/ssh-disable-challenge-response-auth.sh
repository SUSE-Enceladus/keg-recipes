test -f /etc/ssh/sshd_config || cp /usr/etc/ssh/sshd_config /etc/ssh/
sed -i -e "s/#ChallengeResponseAuthentication yes/ChallengeResponseAuthentication no/" \
    /etc/ssh/sshd_config
