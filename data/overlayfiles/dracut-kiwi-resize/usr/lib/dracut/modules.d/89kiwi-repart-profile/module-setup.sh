#!/bin/bash

check() {
    return 255
}

depends() {
    echo rootfs-block dm kiwi-lib
    return 0
}

install() {
    if [[ ! -f /.profile ]]; then
        cp /.kiwi_profile /.profile
    fi
}
