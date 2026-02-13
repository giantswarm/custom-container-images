FROM --platform=linux/amd64 amazon/aws-cli:2.33.22@sha256:ac775d4b3ea7201be968eba207886cdcf0ac54a96f5245a9fae963ab5c75dbdd

RUN yum -y install tar
