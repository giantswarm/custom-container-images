FROM --platform=linux/amd64 amazon/aws-cli:2.34.48@sha256:0b894cdaa3836d70050f293b9e993c546e222458e64e145b93a783efd24a7046

RUN yum -y install tar
