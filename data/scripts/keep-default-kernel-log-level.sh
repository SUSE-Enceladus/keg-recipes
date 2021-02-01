# Keep the default kernel log level (bsc#1169201)
sed -i -e 's/$klogConsoleLogLevel/#$klogConsoleLogLevel/' /etc/rsyslog.conf
