selinux_config=/etc/selinux/config
if test -e $selinux_config && grep -q '^SELINUX=' $selinux_config ; then
    sed -i -e 's/^SELINUX=.*/SELINUX=enforcing/' $selinux_config
else
    echo "SELINUX=enforcing" >> $selinux_config
fi
