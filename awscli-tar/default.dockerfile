FROM --platform=linux/amd64 amazon/aws-cli:2.39.3@sha256:49609865f0e326f6c22e4e6e4c6b9a3d6638b6faaa1d71bda1ac089aa493ccfb

RUN yum -y install tar
