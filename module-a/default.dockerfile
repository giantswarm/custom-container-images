FROM --platform=linux/amd64 ubuntu:noble

RUN echo "module-a" > /root/whoami.txt

ENTRYPOINT ["/usr/bin/cat", "/root/whoami.txt"]
