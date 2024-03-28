# Start expand variables in /usr/lib/motd.d
#
source /etc/os-release

OS_PRETTY_NAME="$PRETTY_NAME"
OS_VERSION_MAJOR="${VERSION_ID%.*}"
OS_VERSION="${VERSION_ID}"
ARCH="`uname -m`"

motd_func="\
s/{OS_PRETTY_NAME}/$OS_PRETTY_NAME/g
s/{OS_VERSION_MAJOR}/$OS_VERSION_MAJOR/g
s/{OS_VERSION}/$OS_VERSION/g
s/{ARCH}/$ARCH/g"

for motd in /usr/lib/motd.d/* ; do
    test -f $motd || continue
    sed -i -e "$motd_func" $motd
done
#
# End expand variables in /usr/lib/motd.d
