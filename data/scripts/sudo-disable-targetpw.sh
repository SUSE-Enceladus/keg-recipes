sed -i -e '/^Defaults targetpw/ s/^/#/' \
       -e '/^ALL *ALL=(ALL) *ALL/ s/^/#/' /etc/sudoers
