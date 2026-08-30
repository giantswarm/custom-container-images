FROM --platform=linux/amd64 alpine/git:v2.54.0@sha256:4f9488b7295baec153a9953479690f835ad4699b1d9f11e3897a4485c224fc3e

RUN apk add --no-cache ca-certificates

RUN addgroup -g 1000 -S giantswarm && adduser -u 1000 -S giantswarm -G giantswarm

USER giantswarm
