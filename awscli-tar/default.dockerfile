FROM --platform=linux/amd64 amazon/aws-cli:2.38.1@sha256:387821d4c8ac3a462e7a7f9ffd6dae99288c9fbf84888e519ed68245fd5e0f8b

RUN yum -y install tar
