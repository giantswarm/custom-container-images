FROM --platform=linux/amd64 amazon/aws-cli:2.34.37@sha256:bcc201d94b1572ae817c8d7b2ff311904ee09d489179a4e3cc02149429f4346e

RUN yum -y install tar
