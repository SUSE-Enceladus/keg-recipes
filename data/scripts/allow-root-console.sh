grep -q '^ttyS0$' /etc/securetty || echo ttyS0 >> /etc/securetty
