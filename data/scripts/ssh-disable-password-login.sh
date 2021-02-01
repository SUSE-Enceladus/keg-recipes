# Disable password based login via ssh
ssh_option=ChallengeResponseAuthentication
sed -i -e "s/#${ssh_option} yes/${ssh_option} no/" \
    -e 's/#PasswordAuthentication yes/PasswordAuthentication no/' \
    /etc/ssh/sshd_config
