FROM --platform=linux/amd64 quay.io/calico/ctl:v3.32.1

FROM gsoci.azurecr.io/giantswarm/alpine:3.24.1

COPY --from=0 /calicoctl /calicoctl

ENV PATH=$PATH:/

ENTRYPOINT ["calicoctl"]
