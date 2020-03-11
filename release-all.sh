#! /bin/bash
# Release each version

echo "Cloning assets"
if [ ! -d /tmp/kubernetes-json-schema ]; then git clone -b master https://github.com/instrumenta/kubernetes-json-schema --single-branch /tmp/kubernetes-json-schema; fi

echo "Releasing Docker images for all API versions with $(grep 'caddy-version=' makefile)"
for FILE in /tmp/kubernetes-json-schema/*-standalone
do
  VERSION=$(echo "${FILE}" | sed -e 's|/tmp/kubernetes-json-schema/||g')
  echo "Releasing ${VERSION}"
  echo "File ${FILE}"
  mkdir -p kubernetes-json-schema
  cp -r "${FILE}/" "kubernetes-json-schema/${VERSION}/"
  make release kubernetes-json-schema-version=${VERSION}
  # rm -rf kubernetes-json-schema
done