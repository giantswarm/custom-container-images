FROM --platform=linux/amd64 amazon/aws-cli:2.37.12@sha256:4295c1f8da478a3aaa1e015b2d4b3772ae9cdd104ce891e4008efb9592d3ce82

RUN yum -y install tar
