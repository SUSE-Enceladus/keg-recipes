#=====================================
# Configure snapper
#-------------------------------------
if [ "${kiwi_btrfs_root_is_snapshot-false}" = 'true' ]; then
        echo "creating initial snapper config ..."
        snapper_templ=/usr/share/snapper/config-templates/default
        test -f $snapper_templ || snapper_templ=/etc/snapper/config-templates/default
        cp $snapper_templ /etc/snapper/configs/root
        baseUpdateSysConfig /etc/sysconfig/snapper SNAPPER_CONFIGS root

        # Adjust parameters
        sed -i'' 's/^TIMELINE_CREATE=.*$/TIMELINE_CREATE="no"/g' /etc/snapper/configs/root
        sed -i'' 's/^NUMBER_LIMIT=.*$/NUMBER_LIMIT="2-10"/g' /etc/snapper/configs/root
        sed -i'' 's/^NUMBER_LIMIT_IMPORTANT=.*$/NUMBER_LIMIT_IMPORTANT="4-10"/g' /etc/snapper/configs/root
fi

# The %post script can't edit /etc/fstab sys due to https://github.com/OSInside/kiwi/issues/945
# so use the kiwi custom hack
cat >/etc/fstab.script <<"EOF"
#!/bin/sh
set -eux

/usr/sbin/setup-fstab-for-overlayfs
EOF
chmod a+x /etc/fstab.script
