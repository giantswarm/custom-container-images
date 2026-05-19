FROM --platform=linux/amd64 amazon/aws-cli:2.34.50@sha256:6c78a2220017a580a61b84abe723a0df8231792387881aa7751ddaa0c904be35

RUN yum -y install tar
