FROM --platform=linux/amd64 node:24-alpine

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

# Install current Claude Code globally
RUN npm install -g @anthropic-ai/claude-code

# Install Python tools
RUN pip3 install --break-system-packages uv tldr

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
