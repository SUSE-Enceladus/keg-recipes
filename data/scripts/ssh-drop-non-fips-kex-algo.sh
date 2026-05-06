# Drop Key Exchange Algorithm that is not fips approved for ssh
# bsc#1259495, bsc#1262555
sed -i -e 's/mlkem768x25519-sha256,*//g; s/,,/,/g; s/,$//g' \
    /etc/crypto-policies/back-ends/opensshserver.config
