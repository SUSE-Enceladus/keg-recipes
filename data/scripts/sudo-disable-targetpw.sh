test -f /etc/sudoers || cp /usr/etc/sudoers /etc/
sed -i -e '/^Defaults targetpw/ s/^/#/' \
       -e '/^ALL *ALL=(ALL) *ALL/ s/^/#/' /etc/sudoers
