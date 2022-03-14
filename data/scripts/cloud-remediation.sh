# Run the image hardening script and then remove the package after completion
/usr/bin/bash -e /usr/bin/cloud-remediation.sh
zypper --non-interactive rm cloud-remediation
