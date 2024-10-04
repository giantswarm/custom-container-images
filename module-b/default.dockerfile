FROM --platform=linux/amd64 ubuntu:noble

RUN echo "module-b - test 7" > /root/whoami.txt

ENTRYPOINT ["/usr/bin/cat", "/root/whoami.txt"]
