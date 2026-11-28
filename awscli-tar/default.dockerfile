FROM --platform=linux/amd64 amazon/aws-cli:2.42.5@sha256:20578a923b6838cc9fe7794bd3c39f19ac08f9580cfc55a1b6fc4e78aa81b8bc

RUN yum -y install tar
