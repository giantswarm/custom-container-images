FROM --platform=linux/amd64 quay.io/calico/ctl:v3.31.4

FROM gsoci.azurecr.io/giantswarm/alpine:3.23.3

COPY --from=0 /calicoctl /calicoctl

ENV PATH=$PATH:/

ENTRYPOINT ["calicoctl"]
