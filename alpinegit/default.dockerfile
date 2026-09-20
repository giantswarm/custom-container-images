FROM --platform=linux/amd64 alpine/git:v2.54.0@sha256:ae0f6f4bce38d2b8c40becc0d6241a08d9f57186ea03029de2189a2b5e722d94

RUN apk add --no-cache ca-certificates

RUN addgroup -g 1000 -S giantswarm && adduser -u 1000 -S giantswarm -G giantswarm

USER giantswarm
