FROM --platform=linux/amd64 amazon/aws-cli:2.35.14@sha256:1d3838b12b1dd936827256365754bb9141a99443f573e7e9ae55cc83e93ff1b0

RUN yum -y install tar
