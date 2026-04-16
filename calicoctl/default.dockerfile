FROM --platform=linux/amd64 quay.io/calico/ctl:v3.31.5

FROM gsoci.azurecr.io/giantswarm/alpine:3.23.4

COPY --from=0 /calicoctl /calicoctl

ENV PATH=$PATH:/

ENTRYPOINT ["calicoctl"]
