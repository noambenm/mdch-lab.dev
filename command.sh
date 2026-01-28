flux push artifact oci://me-west1-docker.pkg.dev/noambesandbox/mdch-lab/pihole:$(git rev-parse --short HEAD) \
	--path="./apps/base/pihole" \
	--source="$(git config --get remote.origin.url)" \
	--revision="$(git branch --show-current)@sha1:$(git rev-parse HEAD)


flux tag artifact oci://me-west1-docker.pkg.dev/noambesandbox/mdch-lab/pihole:$(git rev-parse --short HEAD) \
  --tag latest
