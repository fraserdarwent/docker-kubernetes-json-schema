caddy-version=2.0.0-beta.13
kubernetes-json-schema-version=master
image-name=kubernetes-json-schema
reason=local
overwrite=false

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
			
			rm -f /tmp/versions_local.txt
			for FILE in /tmp/kubernetes-json-schema/*-standalone-strict; do echo "$$(echo "$${FILE}" | sed -e 's|/tmp/kubernetes-json-schema/||g' -e 's|-standalone-strict||g')" >> /tmp/versions_local.txt; done

			rm -f /tmp/versions_remote.txt
			wget -q https://registry.hub.docker.com/v1/repositories/fraserdarwent/kubernetes-json-schema/tags -O -  | sed -e 's/[][]//g' -e 's/"//g' -e 's/ //g' | tr '}' '\n'  | awk -F: '{print $$3}' > /tmp/versions_remote.txt
			
			for VERSION in $$(cat /tmp/versions_local.txt); do (grep "$${VERSION}" /tmp/versions_remote.txt > /dev/null && echo "Found $${VERSION} remotely") || (echo "Could not find $${VERSION} remotely" && if [ "$(overwrite)" == "false" ]; then make release kubernetes-json-schema-version=$${VERSION}; fi); done
checks: 
			if [ "$(reason)" != "local" ]; then docker login -u fraserdarwent -p $${DOCKERHUB_ACCESS_TOKEN}; fi