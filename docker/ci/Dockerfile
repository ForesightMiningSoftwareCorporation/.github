ARG GITHUB_RUNNER_VERSION=latest
FROM myoung34/github-runner:$GITHUB_RUNNER_VERSION
ARG RUST_VERSION=stable
ARG SCCACHE_VERSION=0.7.7

RUN sudo apt-get update && sudo apt-get install -y \
    software-properties-common \
    build-essential \
    zip \
    make \
    gcc \
    libpq-dev \
    wget \
    postgresql \
    gnupg \
    lsb-release \
    curl \
    tar \
    unzip \
    zip \
    apt-transport-https \
    ca-certificates \
    gpg-agent \
    software-properties-common \
    build-essential \
    zlib1g-dev \
    zstd \
    gettext \
    libcurl4-openssl-dev \
    inetutils-ping \
    wget \
    dirmngr \
    openssh-client \
    locales \
    python3-pip \
    python3-setuptools \
    python3-venv \
    python3 \
    dumb-init \
    rsync \
    libpq-dev \
    gosu \
    pkg-config \
    moreutils \
    jq

# Install Node v20 and AWS CDK
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - \
    && sudo apt-get install -y nodejs

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain $RUST_VERSION -y
ENV PATH="/home/runner/.cargo/bin:${PATH}"

# Install sccache
RUN wget https://github.com/mozilla/sccache/releases/download/v$SCCACHE_VERSION/sccache-v$SCCACHE_VERSION-x86_64-unknown-linux-musl.tar.gz \
    && tar xzf sccache-v$SCCACHE_VERSION-x86_64-unknown-linux-musl.tar.gz \
    && sudo mv sccache-v$SCCACHE_VERSION-x86_64-unknown-linux-musl/sccache /usr/local/bin/sccache \
    && sudo chmod +x /usr/local/bin/sccache

# Install GH CLI
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && sudo apt update && sudo apt install -y gh

RUN sudo rm -rf /var/lib/apt/lists/*
