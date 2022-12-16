# Start generate /etc/motd
#
source /etc/os-release

OS_PRETTY_NAME="$PRETTY_NAME"
OS_VERSION_MAJOR="${VERSION_ID%.*}"
ARCH="`uname -m`"

for suma_prod in /etc/products.d/SUSE-Manager-Server.prod /etc/products.d/SUSE-Manager-Proxy.prod
do
  if [[ -f $suma_prod ]]; then
     SUMA_VERSION=`sed -n -r -e '/<version>/s/( *<version>)([^<]*)(.*)/\2/p' $suma_prod`
     break
  fi
done

test -f etc/products.d/SLES_SAP.prod && OS_PRETTY_NAME="$OS_PRETTY_NAME for SAP Applications"

get_motd_includes()
{
    if [ -d /etc/motd.d ]; then
        for inc in `ls /etc/motd.d` ; do
            echo "r /etc/motd.d/${inc}"
        done
    fi
}

test -f /etc/motd-caption && cap_replace="r /etc/motd-caption"

motd_func="\
s/{OS_PRETTY_NAME}/$OS_PRETTY_NAME/g
s/{OS_VERSION_MAJOR}/$OS_VERSION_MAJOR/g
s/{ARCH}/$ARCH/g
s/{SUMA_VERSION}/$SUMA_VERSION/g
/{CAPTION}/{
$cap_replace
d
}
/{INCLUDES}/{
`get_motd_includes`
d
}"

for motd in /etc/motd* ; do
    test -f $motd || continue
    sed -i -e "$motd_func" $motd
done

test -d /etc/motd.d && rm -r /etc/motd.d
test -f /etc/motd-caption && rm /etc/motd-caption
#
# End generate /etc/motd
