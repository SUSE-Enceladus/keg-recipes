#!/bin/bash

# Only installs a vesion of kiwi-partitions-lib.sh that has a fallback
# for version of lsblk that do not support the START output field (bsc#1257265).

# called by dracut
check() {
    return 0
}

# called by dracut
depends() {
    return 0
}

# called by dracut
install() {
    declare moddir=${moddir}
    inst_simple \
        "${moddir}/kiwi-partitions-lib.sh" "/lib/kiwi-partitions-lib.sh"
}
