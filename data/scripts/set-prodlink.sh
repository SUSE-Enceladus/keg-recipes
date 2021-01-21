prodfile=(`grep -l '<codestream>' /etc/products.d/*prod`)
if [[ ${#prodfile[*]} -ne 1 ]]; then
    echo "No base product package installed or base product ambiguous." >&2
    false
else
    ln -sf `basename "${prodfile[0]}"` /etc/products.d/baseproduct
fi
