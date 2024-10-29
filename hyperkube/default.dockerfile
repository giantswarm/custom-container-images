FROM --platform=linux/amd64 registry.k8s.io/kube-apiserver:v1.30.4

FROM quay.io/giantswarm/alpine:3.12.1 AS downloader

WORKDIR /tmp/hyperkube

COPY --from=0 /usr/local/bin/kube-apiserver /tmp/hyperkube/kube-apiserver

RUN KUBERNETES_VERSION=$(/tmp/hyperkube/kube-apiserver --version | grep Kubernetes | cut -d ' ' -f 2) && \
  wget -t 5 https://storage.googleapis.com/kubernetes-release/release/$KUBERNETES_VERSION/bin/linux/amd64/kubelet && \
  wget -t 5 https://storage.googleapis.com/kubernetes-release/release/$KUBERNETES_VERSION/bin/linux/amd64/kubectl && \
  chmod +x /tmp/hyperkube/kubelet /tmp/hyperkube/kubectl

FROM scratch

COPY --from=downloader /tmp/hyperkube/kubelet /kubelet

COPY --from=downloader /tmp/hyperkube/kubectl /kubectl
