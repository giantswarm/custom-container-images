FROM --platform=linux/amd64 alpine/git:v2.52.0@sha256:f1c2b32c4de330955342b3b073ccbdaf772030bd48619f2809231e88578911ba

RUN apk add --no-cache ca-certificates

RUN addgroup -g 1000 -S giantswarm && adduser -u 1000 -S giantswarm -G giantswarm

USER giantswarm
