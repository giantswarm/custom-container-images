FROM --platform=linux/amd64 amazon/aws-cli:2.34.29@sha256:a21c9fdf2ae8427b79d93d5a618aea12068da4864bd58072fa5436fd0ca9539d

RUN yum -y install tar
