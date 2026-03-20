FROM --platform=linux/amd64 gsoci.azurecr.io/giantswarm/python:3.12.0-alpine3.18

RUN apk --no-cache add \
    build-base \
    curl \
    git \
    jq \
    libffi-dev \
    yaml-dev

ENV PYTHONUNBUFFERED=yes

RUN pip install --no-cache-dir \
        click==8.3.1 \
        colored==2.3.1 \
        GitPython==3.1.46 \
        PyGithub==2.8.1 \
        requests==2.32.5 \
        markdown==3.10.2 \
        html2text==2025.4.15 \
        python-dateutil==2.9.0.post0 \
        python-frontmatter==1.1.0 \
        PyYAML==6.0.3

ENTRYPOINT ["python3"]
