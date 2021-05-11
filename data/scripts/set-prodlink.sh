prodfiles=(`grep -l '<codestream>' /etc/products.d/*prod`)
for p in $prodfiles ; do
  grep -q '<flavor>extension</flavor>' $p || prodfile="$prodfile $p"
done
if [[ ${#prodfile[*]} -ne 1 ]]; then
    echo "No base product package installed or base product ambiguous." >&2
    false
else
    ln -sf `basename "${prodfile[0]}"` /etc/products.d/baseproduct
fi
