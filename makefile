caddy-version = 2.0.0-beta.13
kubernetes-json-schema-version = 1.15.1
build:
			docker build . -t fraserdarwent/docker-kubernetes-json-schema:$(kubernetes-json-schema-version) --build-arg KUBERNETES_JSON_SCHEMA_VERSION=$(kubernetes-json-schema-version) --build-arg CADDY_VERSION=$(caddy-version)