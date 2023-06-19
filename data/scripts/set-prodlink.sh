# NOTE: This needs to be adapted to ALP
readarray -t prodfiles < <(grep -l '<codestream>' /etc/products.d/*prod)
base_prodfiles=()
for p in "${prodfiles[@]}" ; do
    grep -q '<flavor>' "$p" || base_prodfiles+=("$p")
done
if [[ ${#base_prodfiles[*]} -ne 1 ]]; then
    echo "No base product package installed or base product ambiguous." >&2
    false
else
    ln -sf `basename "${base_prodfiles[0]}"` /etc/products.d/baseproduct
fi
