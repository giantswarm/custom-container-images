FROM --platform=linux/amd64 alpine/git:v2.26.2@sha256:7b94cd6038bf3f5ddd7b1d99b9591f243e6484417bc5fb8fa7fdbc076e904794

RUN apk add --no-cache ca-certificates

RUN addgroup -g 1000 -S giantswarm && adduser -u 1000 -S giantswarm -G giantswarm

USER giantswarm
