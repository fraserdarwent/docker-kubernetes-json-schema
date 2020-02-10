#! /bin/bash
# Release each version
for version in $(cat versions.txt)
do
  make release kubernetes-json-schema-version=${version}
done
# Release master
make release