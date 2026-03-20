FROM --platform=linux/amd64 node:24.13.0-alpine3.23

RUN apk add --no-cache \
    bash \
    git \
    github-cli \
    curl \
    wget \
    python3 \
    py3-pip \
    build-base \
    jq \
    ripgrep \
    fd \
    bat \
    tree \
    httpie \
    rsync \
    shellcheck

# Install Claude Code globally
RUN npm install -g @anthropic-ai/claude-code@2.1.36

# Install Python tools
RUN pip3 install \
  --break-system-packages \
  uv==0.10.0 \
  tldr==3.4.4

# Create a non-root user
RUN adduser -s bash -D user

# Create necessary directories
RUN mkdir -p /home/user/.config/claude-code \
    && mkdir -p /home/user/.local/bin \
    && chown -R user:user /home/user

# Copy entrypoint script
COPY --chmod=755 entrypoint.sh /usr/local/bin/entrypoint.sh

# Switch to user
USER user
WORKDIR /home/user

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
