FROM --platform=linux/amd64 amazon/aws-cli:2.33.27@sha256:f5a96c567154ee09d8446d400dad5c022e8e8cae3f080d15b9b3339616a1265a

RUN yum -y install tar
