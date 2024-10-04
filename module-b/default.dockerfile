FROM --platform=linux/amd64 ubuntu:noble

RUN echo "module-b - test 6" > /root/whoami.txt

ENTRYPOINT ["/usr/bin/cat", "/root/whoami.txt"]
