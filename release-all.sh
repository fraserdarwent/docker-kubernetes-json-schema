#! /bin/bash
# Release each version
echo "Releasing Docker images for all API versions with $(grep 'caddy-version=' makefile)"
for version in $(cat versions.txt)
do
  make release kubernetes-json-schema-version=${version}
done
# Release master
make release