img_dir=/usr/share/suse-docker-images/native

for img_meta in ${img_dir}/*metadata ; do
    img_name=$(jq -c '.["image"]["name"]' < ${img_meta} | tr -d '"\n')
    img_file=$(jq -c '.["image"]["file"]' < ${img_meta} | tr -d '"\n')
    img_tags=$(jq -c '.["image"]["tags"]' <  ${img_meta} | tr -d '[]"\n' | tr ',' ' ')
    podman_name=$(podman load -i "${img_dir}/${img_file}" | grep -E "^Loaded image:" | cut -d' ' -f3)
    podman_tag=${podman_name#*:}
    echo "Loaded image: $podman_name"
    for tag in $img_tags ; do
        test "$tag" = "$podman_tag" && continue
        echo "Adding tag $tag to $podman_name"
        podman tag ${podman_name} ${img_name}:$tag
    done
    zypper --non-interactive rm ${img_name}-image
done
