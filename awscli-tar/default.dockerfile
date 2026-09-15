FROM --platform=linux/amd64 amazon/aws-cli:2.36.46@sha256:696ad2e7f8aac020bbbeaa511713cc844131ce593b275fdb101285ab02f6cbca

RUN yum -y install tar
