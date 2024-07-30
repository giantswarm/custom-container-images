FROM --platform=linux/amd64 gcr.io/heptio-images/eventrouter:v0.3@sha256:dba60a88600d2d94fcd4c365e2931e54ae9aa495e94a924f80814e019b7ea046

USER root

RUN addgroup -g 1000 -S giantswarm && adduser -u 1000 -S giantswarm -G giantswarm

USER giantswarm
