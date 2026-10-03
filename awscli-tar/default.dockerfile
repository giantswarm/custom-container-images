FROM --platform=linux/amd64 amazon/aws-cli:2.37.9@sha256:add25bee15b7dca32ebb19d348f4fa07074dddd432ad512eba43a6d55bbb74d4

RUN yum -y install tar
