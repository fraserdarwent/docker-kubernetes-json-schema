# Only used for getting assets, so version is not very important
ARG ALPINE_VERSION=latest
ARG CADDY_VERSION

FROM alpine:${ALPINE_VERSION} AS assets

RUN apk add git

RUN git clone -b master https://github.com/instrumenta/kubernetes-json-schema --single-branch

FROM fraserdarwent/docker-caddy:${CADDY_VERSION}
ARG KUBERNETES_JSON_SCHEMA_VERSION
COPY --from=assets /kubernetes-json-schema/v${KUBERNETES_JSON_SCHEMA_VERSION} /kubernetes-json-schema/v${KUBERNETES_JSON_SCHEMA_VERSION}

CMD [ "file-server", "--listen", ":8080" ]