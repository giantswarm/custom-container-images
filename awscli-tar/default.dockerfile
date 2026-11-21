FROM --platform=linux/amd64 amazon/aws-cli:2.42.1@sha256:7a878f76b10d19718cc25851a92a8eef6e0d5105569071e51b0480694776a8c9

RUN yum -y install tar
