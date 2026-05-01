FROM --platform=linux/amd64 amazon/aws-cli:2.34.41@sha256:ddc1cd210af0c78aa1eb01af46610867929afefa1cf46871c55d423493d1246d

RUN yum -y install tar
