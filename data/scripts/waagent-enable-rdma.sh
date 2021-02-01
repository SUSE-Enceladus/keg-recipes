# HPC only. While there is no more specific driver we still need to enable
# RDMA to make the logic in the agent set up the IB interface
sed -i -e 's/# OS.EnableRDMA=y/OS.EnableRDMA=y/' /etc/waagent.conf
