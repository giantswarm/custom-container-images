FROM --platform=linux/amd64 amazon/aws-cli:2.39.6@sha256:3a51e4b63c34883f1fff4a6f2f6a82b0b4bd16a2ea693e875d06a4f406a5f6c7

RUN yum -y install tar
