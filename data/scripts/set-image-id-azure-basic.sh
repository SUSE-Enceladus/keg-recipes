# set IMAGE_ID only if script runs in profile Azure-Basic
if [[ Azure-Basic =~ ^(${profiles})$ ]];
    echo 'IMAGE_ID="sles-basic"' >> /etc/os-release
fi
