caddy-version=2.0.0-beta.13
kubernetes-json-schema-version=v1.15.1
name=kubernetes-json-schema
build:
			docker build . -t fraserdarwent/$(name):$(kubernetes-json-schema-version) --build-arg KUBERNETES_JSON_SCHEMA_VERSION=$(kubernetes-json-schema-version) --build-arg CADDY_VERSION=$(caddy-version)
release:
			make build

			docker tag fraserdarwent/$(name):$(kubernetes-json-schema-version) fraserdarwent/$(name):latest
			docker tag fraserdarwent/$(name):$(kubernetes-json-schema-version) fraserdarwent/$(name):$(kubernetes-json-schema-version)-$(caddy-version)
			
			docker push fraserdarwent/$(name):$(kubernetes-json-schema-version)
			docker push fraserdarwent/$(name):latest
			docker push fraserdarwent/$(name):$(kubernetes-json-schema-version)-$(caddy-version)