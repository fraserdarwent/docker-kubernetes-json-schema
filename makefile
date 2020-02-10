caddy-version = 2.0.0-beta.13
kubernetes-json-schema-version = master
build:
			docker build . -t fraserdarwent/docker-kubernetes-json-schema:$(kubernetes-json-schema-version) --build-arg KUBERNETES_JSON_SCHEMA_VERSION=$(kubernetes-json-schema-version) --build-arg CADDY_VERSION=$(caddy-version)
release:
			make build

			docker tag fraserdarwent/docker-kubernetes-json-schema:$(kubernetes-json-schema-version) fraserdarwent/docker-kubernetes-json-schema:latest
			docker tag fraserdarwent/docker-kubernetes-json-schema:$(kubernetes-json-schema-version) fraserdarwent/docker-kubernetes-json-schema:$(kubernetes-json-schema-version)-$(caddy-version)
			
			docker push fraserdarwent/docker-kubernetes-json-schema:$(kubernetes-json-schema-version)
			docker push fraserdarwent/docker-kubernetes-json-schema:latest
			docker push fraserdarwent/docker-kubernetes-json-schema:$(kubernetes-json-schema-version)-$(caddy-version)