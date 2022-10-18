sed -i 's/node.session.timeo.replacement_timeout/# node.session.timeo.replacement_timeout' /etc/iscsi/iscsid.conf
sed -i 's/node.conn[0].timeo.noop_out_interval/# node.conn[0].timeo.noop_out_interval' /etc/iscsi/iscsid.conf
sed -i 's/node.conn[0].timeo.noop_out_timeout/# node.conn[0].timeo.noop_out_timeout' /etc/iscsi/iscsid.conf
