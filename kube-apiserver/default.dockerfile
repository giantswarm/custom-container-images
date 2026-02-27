FROM --platform=linux/amd64 registry.k8s.io/kube-apiserver:v1.35.2

RUN apt-get update && apt-get install -y ca-certificates && rm -rf /var/lib/apt/lists/*
