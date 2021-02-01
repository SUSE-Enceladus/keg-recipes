# Implement password policy
# Length: 6-72 characters long
# Contain any combination of 3 of the following:
#   - a lowercase character
#   - an uppercase character
#   - a number
#   - a special character
pwd_policy="minlen=6 dcredit=1 ucredit=1 lcredit=1 ocredit=1 minclass=3"
sed -i -e "s/pam_cracklib.so/pam_cracklib.so $pwd_policy/" \
    /etc/pam.d/common-password-pc
