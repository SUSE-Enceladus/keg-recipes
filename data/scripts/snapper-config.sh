#=====================================
# Configure snapper
#-------------------------------------
if [ "${kiwi_btrfs_root_is_snapshot-false}" = 'true' ]; then
        echo "creating initial snapper config ..."
        cp /usr/share/snapper/config-templates/default /etc/snapper/configs/root
        baseUpdateSysConfig /etc/sysconfig/snapper SNAPPER_CONFIGS root

        # Adjust parameters
        sed -i'' 's/^TIMELINE_CREATE=.*$/TIMELINE_CREATE="no"/g' /etc/snapper/configs/root
        sed -i'' 's/^NUMBER_LIMIT=.*$/NUMBER_LIMIT="2-10"/g' /etc/snapper/configs/root
        sed -i'' 's/^NUMBER_LIMIT_IMPORTANT=.*$/NUMBER_LIMIT_IMPORTANT="4-10"/g' /etc/snapper/configs/root
fi
