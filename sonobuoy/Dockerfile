FROM --platform=linux/amd64 sonobuoy/sonobuoy:v0.57.1

FROM quay.io/giantswarm/alpine:3.14.0-giantswarm


COPY --from=0 /sonobuoy /sonobuoy

WORKDIR /

CMD ["/sonobuoy", "aggregator", "--no-exit", "-v", "3", "--logtostderr"]
