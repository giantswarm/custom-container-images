ARG TARGETARCH
ARG CLAUDE_CODE_VERSION=2.1.317
ARG CLAUDE_STATUSLINE_VERSION=0.3.0

# Checksums from https://downloads.claude.ai/claude-code-releases/<version>/manifest.json
FROM scratch AS claude-amd64
ARG CLAUDE_CODE_VERSION
ADD --chmod=0755 --checksum=sha256:bcc2be9105875dc31a44825ede92e46c4f98225eeb3ad617340daa217100339b \
    https://downloads.claude.ai/claude-code-releases/${CLAUDE_CODE_VERSION}/linux-x64-musl/claude /claude

FROM scratch AS claude-arm64
ARG CLAUDE_CODE_VERSION
ADD --chmod=0755 --checksum=sha256:dc8c59cf937e60e9cc93afe226ef437474ded56ba813743d09106d24a08c83bd \
    https://downloads.claude.ai/claude-code-releases/${CLAUDE_CODE_VERSION}/linux-arm64-musl/claude /claude

FROM claude-${TARGETARCH} AS claude

# The default status line. Checksums from the GitHub release assets of
# https://github.com/TheoBrigitte/claude-statusline
FROM scratch AS statusline-amd64
ARG CLAUDE_STATUSLINE_VERSION
ADD --chmod=0755 --checksum=sha256:7ff9ce85d6cd78ac7bd6e42bf2cd4623f7cdba7ed59748180da5f279cd50d7b0 \
    https://github.com/TheoBrigitte/claude-statusline/releases/download/v${CLAUDE_STATUSLINE_VERSION}/claude-statusline.linux-amd64 /claude-statusline

FROM scratch AS statusline-arm64
ARG CLAUDE_STATUSLINE_VERSION
ADD --chmod=0755 --checksum=sha256:6168039cdf992f9e8625e20b0254c81faed6f7f95b9035c359ecdc1370b90c2e \
    https://github.com/TheoBrigitte/claude-statusline/releases/download/v${CLAUDE_STATUSLINE_VERSION}/claude-statusline.linux-arm64 /claude-statusline

FROM statusline-${TARGETARCH} AS statusline

FROM gsoci.azurecr.io/giantswarm/alpine:3.24.3

RUN apk add --no-cache bash ca-certificates coreutils curl diffutils findutils gawk git grep gzip jq libgcc libstdc++ procps-ng python3 sed tar tini which \
 && addgroup -g 1000 node \
 && adduser -D -u 1000 -G node -h /home/node -s /bin/bash node \
 && install -d -m 0755 /etc/claude-code

COPY --from=claude /claude /usr/local/bin/claude
COPY --from=statusline /claude-statusline /usr/local/bin/claude-statusline
COPY --chmod=0755 start.sh beam-mcp-wrap beam-mcp-headers /usr/local/bin/
# Users can't override managed settings: no hooks, no tool reads of the secrets.
# The directory exists first: COPY --chmod would give a new one the file's mode.
COPY --chmod=0644 managed-settings.json /etc/claude-code/managed-settings.json

ENV DISABLE_AUTOUPDATER=1 \
    SHELL=/bin/bash \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    CLAUDE_CONFIG_DIR=/run/claude/config

USER node
WORKDIR /home/node
ENTRYPOINT ["/sbin/tini", "--"]
CMD ["/usr/local/bin/start.sh"]
