FROM --platform=linux/amd64 amazon/aws-cli:2.34.14@sha256:0a8bbdb160cbb09e357ba24533204e90a97e2e56beadf1730739644c2d5f1bdb

RUN yum -y install tar
