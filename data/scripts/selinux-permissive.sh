selinux_config=/etc/selinux/config
if test -e $selinux_config && grep -q '^SELINUX=' $selinux_config ; then
    sed -i -e 's/^SELINUX=.*/SELINUX=permissive/' $selinux_config
else
    echo "SELINUX=permissive" >> $selinux_config
fi
