# Disable memory hotplug bsc#1028173
sed -i 's/SUBSYSTEM=="memory"/#SUBSYSTEM=="memory"/' \
    /usr/lib/udev/rules.d/80-hotplug-cpu-mem.rules
