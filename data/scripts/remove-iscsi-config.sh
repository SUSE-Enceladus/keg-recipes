# Generation of the iscsi config file moved to %post of the package
# This implies that all instances have the same iscsi initiator name as the
# file is generated during image build. We do not want this (bsc#1202540)
rm -rf /etc/iscsi/initiatorname.iscsi
