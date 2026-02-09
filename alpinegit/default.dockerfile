FROM --platform=linux/amd64 alpine/git:v2.26.2@sha256:23618034b0be9205d9cc0846eb711b12ba4c9b468efdd8a59aac1d7b1a23363f

RUN apk add --no-cache ca-certificates

RUN addgroup -g 1000 -S giantswarm && adduser -u 1000 -S giantswarm -G giantswarm

USER giantswarm
