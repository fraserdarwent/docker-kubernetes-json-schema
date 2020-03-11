# Only used for getting assets, so version is not very important
ARG ALPINE_VERSION=latest
ARG CADDY_VERSION=latest

FROM alpine:${ALPINE_VERSION} AS assets

RUN apk add git

RUN git clone -b master https://github.com/instrumenta/kubernetes-json-schema --single-branch

FROM fraserdarwent/caddy:${CADDY_VERSION}
ARG KUBERNETES_JSON_SCHEMA_VERSION
ENV KUBERNETES_JSON_SCHEMA_VERSION=${KUBERNETES_JSON_SCHEMA_VERSION}
COPY --from=assets /kubernetes-json-schema/${KUBERNETES_JSON_SCHEMA_VERSION} /kubernetes-json-schema/${KUBERNETES_JSON_SCHEMA_VERSION}
COPY --from=assets /kubernetes-json-schema/${KUBERNETES_JSON_SCHEMA_VERSION}-local /kubernetes-json-schema/${KUBERNETES_JSON_SCHEMA_VERSION}-local
COPY --from=assets /kubernetes-json-schema/${KUBERNETES_JSON_SCHEMA_VERSION}-standalone /kubernetes-json-schema/${KUBERNETES_JSON_SCHEMA_VERSION}-standalone
COPY --from=assets /kubernetes-json-schema/${KUBERNETES_JSON_SCHEMA_VERSION}-standalone-strict /kubernetes-json-schema/${KUBERNETES_JSON_SCHEMA_VERSION}-standalone-strict
COPY Caddyfile /Caddyfile
CMD [ "run" ]