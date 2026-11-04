# The regular beam-claude image: the slim image with developer and Kubernetes
# tools. Releases as beam-claude:<version>. Bump a download: change its version
# here and its two checksums in tools.sha256.
FROM gsoci.azurecr.io/giantswarm/alpine:3.24.3 AS downloads
ARG TARGETARCH
ARG GO_VERSION=1.27.3
ARG GOLANGCI_LINT_VERSION=2.15.0
ARG CIRCLECI_VERSION=1.13.0
ARG DEVCTL_VERSION=8.163.1
ARG KUBECTL_GS_VERSION=5.13.0
COPY tools.sha256 /tmp/
WORKDIR /tmp
RUN set -eu; a=$TARGETARCH; \
    apk add --no-cache curl; \
    curl -fsSLO "https://go.dev/dl/go${GO_VERSION}.linux-$a.tar.gz"; \
    curl -fsSLO "https://github.com/golangci/golangci-lint/releases/download/v${GOLANGCI_LINT_VERSION}/golangci-lint-${GOLANGCI_LINT_VERSION}-linux-$a.tar.gz"; \
    curl -fsSLO "https://github.com/CircleCI-Public/circleci-cli/releases/download/v${CIRCLECI_VERSION}/circleci-cli_${CIRCLECI_VERSION}_linux_$a.tar.gz"; \
    curl -fsSLO "https://github.com/giantswarm/devctl/releases/download/v${DEVCTL_VERSION}/devctl-linux-$a"; \
    curl -fsSLO "https://github.com/giantswarm/kubectl-gs/releases/download/v${KUBECTL_GS_VERSION}/kubectl-gs-linux-$a"; \
    grep "linux[-_.]$a" tools.sha256 | sha256sum -c -; \
    mkdir -p /out/bin; \
    tar -C /out -xzf "go${GO_VERSION}.linux-$a.tar.gz"; \
    tar -xzf "golangci-lint-${GOLANGCI_LINT_VERSION}-linux-$a.tar.gz"; \
    install -m 0755 "golangci-lint-${GOLANGCI_LINT_VERSION}-linux-$a/golangci-lint" /out/bin/; \
    tar -C /out/bin -xzf "circleci-cli_${CIRCLECI_VERSION}_linux_$a.tar.gz" circleci; \
    install -m 0755 "devctl-linux-$a" /out/bin/devctl; \
    install -m 0755 "kubectl-gs-linux-$a" /out/bin/kubectl-gs

FROM gsoci.azurecr.io/giantswarm/beam-claude:0.2.2-slim
USER root
RUN apk add --no-cache github-cli helm imagemagick kubectl make nodejs npm openssl shellcheck uv yq-go
COPY --from=downloads /out/go /usr/local/go
COPY --from=downloads /out/bin/ /usr/local/bin/
ENV PATH=/usr/local/go/bin:$PATH
USER node
