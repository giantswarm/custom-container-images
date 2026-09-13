FROM --platform=linux/amd64 alpine/git:v2.54.0@sha256:0b5f57d22181e8b8fbe8ac5ca8754faa0d577f101b9857418f1acc43955ad464

RUN apk add --no-cache ca-certificates

RUN addgroup -g 1000 -S giantswarm && adduser -u 1000 -S giantswarm -G giantswarm

USER giantswarm
