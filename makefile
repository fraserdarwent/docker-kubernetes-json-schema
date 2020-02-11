caddy-version=2.0.0-beta.13
kubernetes-json-schema-version=master
image-name=kubernetes-json-schema
build:
			docker build . -t fraserdarwent/$(image-name):$(kubernetes-json-schema-version) --build-arg KUBERNETES_JSON_SCHEMA_VERSION=$(kubernetes-json-schema-version) --build-arg CADDY_VERSION=$(caddy-version)
release:
			make build

			docker tag fraserdarwent/$(image-name):$(kubernetes-json-schema-version) fraserdarwent/$(image-name):latest
			docker tag fraserdarwent/$(image-name):$(kubernetes-json-schema-version) fraserdarwent/$(image-name):$(kubernetes-json-schema-version)-$(caddy-version)
			
			docker push fraserdarwent/$(image-name):$(kubernetes-json-schema-version)
			docker push fraserdarwent/$(image-name):latest
			docker push fraserdarwent/$(image-name):$(kubernetes-json-schema-version)-$(caddy-version)