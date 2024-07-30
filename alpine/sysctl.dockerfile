FROM --platform=linux/amd64 alpine:3.20.2

RUN addgroup -g 1000 -S giantswarm && adduser -u 1000 -S giantswarm -G giantswarm

RUN apk add --no-cache sudo && echo "giantswarm  ALL = NOPASSWD: /sbin/sysctl" >> /etc/sudoers

USER giantswarm
