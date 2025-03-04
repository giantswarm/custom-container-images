FROM --platform=linux/amd64 gsoci.azurecr.io/giantswarm/alpine:3.21.3@sha256:a8560b36e8b8210634f77d9f7f9efd7ffa463e380b75e2e74aff4511df3ef88c

RUN apk add apache2-utils=2.4.62-r0

RUN addgroup -g 1000 -S giantswarm && adduser -u 1000 -S giantswarm -G giantswarm

USER giantswarm
