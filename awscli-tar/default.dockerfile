FROM --platform=linux/amd64 amazon/aws-cli:2.34.24@sha256:74ae59a3a47ad6dcf8000e2c65580451c358c3b394e6103802318207108b4436

RUN yum -y install tar
