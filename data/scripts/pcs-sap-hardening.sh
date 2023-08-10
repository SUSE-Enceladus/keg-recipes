# run sap image hardening script
ssg_file="/usr/share/xml/scap/ssg/content/ssg-sle15-ds.xml"

echo "run oscap --profile pcs-hardening-sap"
oscap xccdf eval --remediate --profile pcs-hardening-sap $ssg_file || {
    echo "!!!FAILED: --profile pcs-hardening-sap"
    /bin/false
}

RULES_FROM_CIS=" \
banner_etc_issue_net \
account_disable_post_pw_expiration \
accounts_set_post_pw_existing \
accounts_users_home_files_permissions \
file_permissions_home_directories \
rsyslog_files_permissions \
journald_forward_to_syslog \
rsyslog_remote_loghost \
package_nftables_removed \
permissions_local_var_log \
mount_option_dev_shm_noexec \
file_at_deny_not_exist \
file_cron_deny_not_exist \
package_rpcbind_removed \
package_net-snmp_removed \
sshd_set_keepalive \
disable_host_auth \
sshd_disable_empty_passwords \
sshd_disable_rhosts \
sshd_do_not_permit_user_env \
sshd_set_max_auth_tries \
sshd_use_strong_kex \
"
# NOTE: the following were disabled because they try to read from /proc/sys
# and potentially call sysctl which does not work or make sense in chroot.
#
# sysctl_fs_suid_dumpable
# sysctl_kernel_randomize_va_space
# sysctl_net_ipv6_conf_all_accept_ra
# sysctl_net_ipv6_conf_all_accept_source_route
# sysctl_net_ipv6_conf_all_forwarding
# sysctl_net_ipv6_conf_default_accept_ra
# sysctl_net_ipv6_conf_default_accept_source_route
# sysctl_net_ipv4_conf_all_log_martians
# sysctl_net_ipv4_conf_all_rp_filter
# sysctl_net_ipv4_conf_all_secure_redirects
# sysctl_net_ipv4_conf_default_log_martians
# sysctl_net_ipv4_conf_default_rp_filter
# sysctl_net_ipv4_conf_default_secure_redirects
# sysctl_net_ipv4_icmp_ignore_bogus_error_responses
# sysctl_net_ipv4_tcp_syncookies
# sysctl_net_ipv4_conf_all_send_redirects
# sysctl_net_ipv4_conf_default_send_redirects
# sysctl_net_ipv4_ip_forward

for RULE in ${RULES_FROM_CIS}; do
    RULE_ARGS="$RULE_ARGS --rule xccdf_org.ssgproject.content_rule_$RULE"
done

# remediate selected rules
oscap xccdf eval --remediate $RULE_ARGS $ssg_file
