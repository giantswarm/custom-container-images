FROM --platform=linux/amd64 amazon/aws-cli:2.34.9@sha256:19f21fa4e6bbeac6f6b1f9b167902578bbd8bf0a747cbaa92a892bffff540039

RUN yum -y install tar
