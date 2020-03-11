caddy-version=2.0.0-beta.13
kubernetes-json-schema-version=master
image-name=kubernetes-json-schema
reason=local

build: docker

docker:
			echo "Building Docker image for Kubernetes API version $(kubernetes-json-schema-version) on Caddy version $(caddy-version)"
			docker build . -t fraserdarwent/$(image-name):$(kubernetes-json-schema-version) --build-arg KUBERNETES_JSON_SCHEMA_VERSION=$(kubernetes-json-schema-version) --build-arg CADDY_VERSION=$(caddy-version)
			rm -rf kubernetes-json-schema

release: checks docker
			echo "Releasing Docker image for Kubernetes API version $(kubernetes-json-schema-version) on Caddy version $(caddy-version)"
			docker tag fraserdarwent/$(image-name):$(kubernetes-json-schema-version) fraserdarwent/$(image-name):latest
			docker tag fraserdarwent/$(image-name):$(kubernetes-json-schema-version) fraserdarwent/$(image-name):$(kubernetes-json-schema-version)-$(caddy-version)
			
			docker push fraserdarwent/$(image-name):$(kubernetes-json-schema-version)
			docker push fraserdarwent/$(image-name):latest
			docker push fraserdarwent/$(image-name):$(kubernetes-json-schema-version)-$(caddy-version)
			
assets:
			if [ ! -d /tmp/kubernetes-json-schema ]; then echo "Cloning assets" && git clone -b master https://github.com/instrumenta/kubernetes-json-schema --single-branch /tmp/kubernetes-json-schema; else echo "Assets found"; fi

release-all: checks assets
			echo "Releasing Docker images for all Kubernetes API versions on Caddy version $(caddy-version)"
			for FILE in /tmp/kubernetes-json-schema/*-standalone; do make release kubernetes-json-schema-version=$$(echo "$${FILE}" | sed -e 's|/tmp/kubernetes-json-schema/||g' -e 's|-standalone||g'); done

checks: 
			if [ "$(reason)" != "local" ]; then echo "Running remotely. Please log in" && exit 1; fi