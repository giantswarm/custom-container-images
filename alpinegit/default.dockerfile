FROM --platform=linux/amd64 alpine/git:v2.54.0@sha256:ce84fd6a057b4dc5cf5009da2dd832f1c6d096c1984bf50496cf3c256402264d

RUN apk add --no-cache ca-certificates

RUN addgroup -g 1000 -S giantswarm && adduser -u 1000 -S giantswarm -G giantswarm

USER giantswarm
