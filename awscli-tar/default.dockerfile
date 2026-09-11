FROM --platform=linux/amd64 amazon/aws-cli:2.36.44@sha256:79979622af70b30fee35ef8b7dc105734709525e081f80810e51c2546bd89f4c

RUN yum -y install tar
