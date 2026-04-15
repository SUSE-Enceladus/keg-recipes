if [ -f /etc/zypp/zypp.conf]; then
    sed -i -e 's/latest,latest-1,running/latest,running/' /etc/zypp/zypp.conf
else
    echo "multiversion.kernels = latest" > /etc/zypp/zypp.conf.d/40_multiver_kernel_latest.conf
fi
