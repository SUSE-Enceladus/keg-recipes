# Disable password based login via ssh
sed -i -e 's/#PasswordAuthentication yes/PasswordAuthentication no/' \
    /etc/ssh/sshd_config
