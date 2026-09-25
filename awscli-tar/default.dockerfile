FROM --platform=linux/amd64 amazon/aws-cli:2.37.4@sha256:89797ddaa6879caeb9f1766efb4f57c5c0291a5d7dfe56d0130fc485881e999a

RUN yum -y install tar
