# PM-1830
echo 'VARIANT_ID="chost"' >> /etc/os-release
date_stamp=`date +'%Y%m%d'`
echo "VARIANT_VERSION=\"$date_stamp\"" >> /etc/os-release
