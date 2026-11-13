FROM --platform=linux/amd64 amazon/aws-cli:2.40.3@sha256:f162ca1f87ce845fc3cfcfe7c676234aca819adb2af12257f9da3542a3ca0928

RUN yum -y install tar
