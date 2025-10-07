FROM --platform=linux/amd64 gsoci.azurecr.io/giantswarm/python:3.13.5-alpine

COPY requirements.txt /tmp/requirements.txt

RUN pip3 install --break-system-packages -r /tmp/requirements.txt

ENTRYPOINT ["/usr/local/bin/yamllint"]
