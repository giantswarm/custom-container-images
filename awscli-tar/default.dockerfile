FROM --platform=linux/amd64 amazon/aws-cli:2.36.49@sha256:b47eaab8827b1015999fb6a0bc392c482f07a21a445ae269f8934473e714a1d1

RUN yum -y install tar
