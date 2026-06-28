FROM --platform=linux/amd64 alpine/git:v2.54.0@sha256:e043be20669db13cbcfb6190192babee4cf2dca98709bb0c2d08ca2d35a0a06a

RUN apk add --no-cache ca-certificates

RUN addgroup -g 1000 -S giantswarm && adduser -u 1000 -S giantswarm -G giantswarm

USER giantswarm
