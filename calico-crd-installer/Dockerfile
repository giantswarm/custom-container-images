FROM --platform=linux/amd64 quay.io/calico/kube-controllers:v3.27.4

FROM quay.io/giantswarm/crd-installer:0.2.2 AS installer

FROM quay.io/giantswarm/alpine:3.15.0 AS downloader

WORKDIR /tmp/crd-installer

COPY --from=0 /usr/bin/kube-controllers /crd-installer/kube-controllers

COPY --from=0 /lib64/ /lib64

COPY --from=installer /scripts /scripts

RUN CALICO_VERSION=$(/crd-installer/kube-controllers -version) && /scripts/download-calico-crds.sh $CALICO_VERSION

FROM scratch

COPY --from=downloader /tmp/crd-installer/crds /crds

COPY --from=installer /usr/local/bin/crd-installer /usr/local/bin/crd-installer

CMD ["/usr/local/bin/crd-installer", "-dir", "/crds"]
