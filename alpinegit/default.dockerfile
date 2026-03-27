FROM --platform=linux/amd64 alpine/git:v2.52.0@sha256:d453f54c83320412aa89c391b076930bd8569bc1012285e8c68ce2d4435826a3

RUN apk add --no-cache ca-certificates

RUN addgroup -g 1000 -S giantswarm && adduser -u 1000 -S giantswarm -G giantswarm

USER giantswarm
