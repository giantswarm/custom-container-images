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
        click==8.1.7 \
        colored==2.2.3 \
        GitPython==3.1.40 \
        PyGithub==2.1.1 \
        requests==2.26.0 \
        markdown==3.3.6 \
        html2text==2020.1.16 \
        python-dateutil==2.8.2 \
        python-frontmatter==1.0.1 \
    && pip install \
        --global-option='--with-libyaml' PyYAML==6.0.1

ENTRYPOINT ["python3"]
