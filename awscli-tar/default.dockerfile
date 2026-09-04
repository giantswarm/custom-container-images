FROM --platform=linux/amd64 amazon/aws-cli:2.36.40@sha256:5b3fa9da281ab658171716b2c01beff540614f6697ac6d6ebd8e369aca75fb9c

RUN yum -y install tar
