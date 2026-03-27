FROM --platform=linux/amd64 amazon/aws-cli:2.34.19@sha256:2a42ab831c97444db6294a2e9c87d09aee6c41830acae8445804a5d4d0b78c20

RUN yum -y install tar
