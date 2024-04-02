img_dir=/usr/share/suse-docker-images/native
img_name="localhost/$(jq -c '.["image"]["name"]' <  ${img_dir}/suse-manager-*.metadata | tr -d '"\n' | tr - /)"
tags=$(jq -c '.["image"]["tags"]' <  ${img_dir}/suse-manager-*.metadata | tr -d '[]"\n' | tr ',' ' ')
podman load -i /usr/share/suse-docker-images/native/suse-manager-*-x86_64-server
for tag in $tags ; do
    test "$tag" = "latest" && continue
    podman tag ${img_name}:latest ${img_name}:$tag
done
zypper --non-interactive rm suse-manager-\*-x86_64-server-image
