FROM --platform=linux/amd64 alpine/git:v2.54.1@sha256:2306e2b05ee0ef99f5d25b0779f645b24ae9f91ba187107503592fcdfe78da3a

RUN apk add --no-cache ca-certificates

RUN addgroup -g 1000 -S giantswarm && adduser -u 1000 -S giantswarm -G giantswarm

USER giantswarm
