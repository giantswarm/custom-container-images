FROM --platform=linux/amd64 registry.k8s.io/kube-apiserver:v1.18.9

RUN apt-get update && apt-get install -y ca-certificates && rm -rf /var/lib/apt/lists/*
