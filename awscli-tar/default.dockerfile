FROM --platform=linux/amd64 amazon/aws-cli:2.7.35@sha256:bc83b9e09e3c4aefafb9e0172bfca720dad6b56b13389ed6760f0ef4a0bdaac9

RUN yum -y install tar
