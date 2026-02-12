FROM --platform=linux/amd64 alpine/git:v2.52.0@sha256:3b7890cb947afd3f71adab55aa6b549ad0f8ddc4b9ed28b027563d73d49d8e11

RUN apk add --no-cache ca-certificates

RUN addgroup -g 1000 -S giantswarm && adduser -u 1000 -S giantswarm -G giantswarm

USER giantswarm
