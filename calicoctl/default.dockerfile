FROM --platform=linux/amd64 quay.io/calico/ctl:v3.32.0

FROM gsoci.azurecr.io/giantswarm/alpine:3.23.4

COPY --from=0 /calicoctl /calicoctl

ENV PATH=$PATH:/

ENTRYPOINT ["calicoctl"]
