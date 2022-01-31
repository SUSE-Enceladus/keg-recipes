dc=/etc/dhclient.conf
if grep -qE '^timeout' $dc ; then
    sed -r -i 's/^timeout.*/timeout 300;/' $dc
else
    echo 'timeout 300;' >> $dc
fi
