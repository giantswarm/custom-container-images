FROM --platform=linux/amd64 amazon/aws-cli:2.38.5@sha256:25fea7c13a5b32ac8bde048af1cd286e41f07d5d37e6649f23c14a6f9bf284d9

RUN yum -y install tar
