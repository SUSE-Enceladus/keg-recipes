# run sap image hardening script
echo "run oscap -profile pcs-hardening-sap"
oscap xccdf eval --remediate --profile pcs-hardening-sap /usr/share/xml/scap/ssg/content/ssg-sle15-ds.xml || {
    echo "!!!FAILED: --profile pcs-hardening-sap"
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
sysctl_net_ipv6_conf_all_accept_ra \
sysctl_net_ipv6_conf_all_accept_source_route \
sysctl_net_ipv6_conf_all_forwarding \
sysctl_net_ipv6_conf_default_accept_ra \
sysctl_net_ipv6_conf_default_accept_source_route \
sysctl_net_ipv4_conf_all_log_martians \
sysctl_net_ipv4_conf_all_rp_filter \
sysctl_net_ipv4_conf_all_secure_redirects \
sysctl_net_ipv4_conf_default_log_martians \
sysctl_net_ipv4_conf_default_rp_filter \
sysctl_net_ipv4_conf_default_secure_redirects \
sysctl_net_ipv4_icmp_ignore_bogus_error_responses \
sysctl_net_ipv4_tcp_syncookies \
sysctl_net_ipv4_conf_all_send_redirects \
sysctl_net_ipv4_conf_default_send_redirects \
sysctl_net_ipv4_ip_forward \
package_nftables_removed \
permissions_local_var_log \
mount_option_dev_shm_noexec \
sysctl_fs_suid_dumpable \
sysctl_kernel_randomize_va_space \
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

# remediate selected rules
for RULE in ${RULES_FROM_CIS}; do
    echo "run oscap -profile cis_server_l ${RULE}"
    oscap xccdf eval --remediate --profile cis_server_l1 --rule xccdf_org.ssgproject.content_rule_${RULE}  /usr/share/xml/scap/ssg/content/ssg-sle15-ds.xml || {
	echo "!!!FAILED: ${RULE}"
	}
done
