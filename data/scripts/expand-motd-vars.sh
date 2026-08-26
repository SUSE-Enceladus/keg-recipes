# Start expand variables in /usr/lib/motd.d
#
source /etc/os-release

OS_PRETTY_NAME="$PRETTY_NAME"
OS_VERSION_MAJOR="${VERSION_ID%.*}"
OS_VERSION="${VERSION}"
ARCH="`uname -m`"
PROD_ID="$(echo $CPE_NAME | cut -d: -f 4 | tr '_' '-')"
PROD_VERSION="${VERSION}"

# SLES for SAP has standard SLES /etc/os-release
if [ -f etc/products.d/SLES_SAP.prod ]; then
    OS_PRETTY_NAME="$(echo $OS_PRETTY_NAME | sed -e 's/Server/Server for SAP Applications/')"
    PROD_ID="sles-sap"
fi

# get extension info (if installed)
for prod in /etc/products.d/*prod ; do
    grep -q "<flavor>extension</flavor>" $prod || continue
    EXTENSION_VERSION=`sed -n -r -e '/<version>/s/( *<version>)([^<]*)(.*)/\2/p' $prod`
    EXTENSION_NAME=`sed -n -r -e '/<summary>/s/( *<summary>)([^<]*)(.*)/\2/p' $prod`
    EXTENSION_NAME=${EXTENSION_NAME/ Extension/}
done

if [ -n "${EXTENSION_NAME}" -a "${EXTENSION_NAME/Multi-Linux Manager/}" != "${EXTENSION_NAME}" ]; then
    PROD_ID="multi-linux-manager"
    PROD_VERSION="$EXTENSION_VERSION"
fi

motd_func="\
s/{OS_PRETTY_NAME}/$OS_PRETTY_NAME/g
s/{OS_VERSION_MAJOR}/$OS_VERSION_MAJOR/g
s/{OS_VERSION}/$OS_VERSION/g
s/{EXTENSION_NAME}/$EXTENSION_NAME/g
s/{EXTENSION_VERSION}/$EXTENSION_VERSION/g
s/{PROD_ID}/$PROD_ID/g
s/{PROD_VERSION}/$PROD_VERSION/g
s/{ARCH}/$ARCH/g"

for motd in /usr/lib/motd.d/* ; do
    test -f $motd || continue
    sed -i -e "$motd_func" $motd
done
#
# End expand variables in /usr/lib/motd.d
