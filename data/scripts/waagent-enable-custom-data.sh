# Support user data execution to support script execution that joins
# an instance to the cluster
sed -i -e 's/Provisioning.ExecuteCustomData=n/Provisioning.ExecuteCustomData=y/' /etc/waagent.conf
sed -i -e 's/Provisioning.DecodeCustomData=n/Provisioning.DecodeCustomData=y/' /etc/waagent.conf
