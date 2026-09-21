# set IMAGE_ID only if script runs in profile Azure-Basic
if [[ Azure-Basic =~ ^(${profiles})$ ]]; then
    echo 'VARIANT_ID="sles-basic"' >> /etc/os-release
fi
