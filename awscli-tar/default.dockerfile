FROM --platform=linux/amd64 amazon/aws-cli:2.34.32@sha256:4611a918d72fe666b94c4436386bc857a2c765cd5ffa07faaa651330cd5f30a7

RUN yum -y install tar
