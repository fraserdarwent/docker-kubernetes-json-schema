# docker-kubernetes-json-schema
[View on Dockerhub](https://hub.docker.com/repository/docker/fraserdarwent/kubernetes-json-schema)

[Kubernetes JSON Schema](https://github.com/instrumenta/kubernetes-json-schema) packaged onto a [minimal HTTP server](https://github.com/fraserdarwent/docker-caddy). Designed to be used by [Kubeval](https://github.com/instrumenta/kubeval) to validate Kubernetes objects, where public internet access is not possible or desired.

# Tags
- `latest` (current master branch Kubernetes schema)
- `<KUBERNETES_API_VERSION>`
- `<KUBERNETES_API_VERSION>-<CADDY_VERSION>`

# Versions
See [versions file](https://github.com/fraserdarwent/docker-kubernetes-json-schema/blob/master/versions.txt)

# Example Kubeval Usage
Start container
```bash
docker run -p 8080:8080 fraserdarwent/kubernetes-json-schema:v1.15.1
```
Use with [Kubeval](https://github.com/instrumenta/kubeval)
```bash
kubeval rolebinding.yaml --schema-location http://localhost:8080
```
or
```bash
kubeval rolebinding.yaml --schema-location http://localhost:8080 --kubernetes-version 1.15.1
```