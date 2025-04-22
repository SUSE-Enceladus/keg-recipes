test -f /etc/ssh/sshd_config || cp /usr/etc/ssh/sshd_config /etc/ssh/
sed -i -e "s/#ChallengeResponseAuthentication yes/ChallengeResponseAuthentication no/" \
    /etc/ssh/sshd_config
# For the SSHv2 protocol ChallengeResponseAuthentication was replaced by
# KbdInteractiveAuthentication
sed -i -e "s/#KbdInteractiveAuthentication yes/KbdInteractiveAuthentication no/" \
    /etc/ssh/sshd_config
