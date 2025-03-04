FROM --platform=linux/amd64 gsoci.azurecr.io/giantswarm/alpine:3.21.3

RUN apk add apache2-utils=2.4.62-r0

RUN addgroup -g 1000 -S giantswarm && adduser -u 1000 -S giantswarm -G giantswarm

USER giantswarm
