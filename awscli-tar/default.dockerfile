FROM --platform=linux/amd64 amazon/aws-cli:2.7.35@sha256:e5988c45f13ec9c9500e9fb6742e19de642a5bdc2750f2cc0482a857f13c30ea

RUN yum -y install tar
