ARG GITHUB_RUNNER_VERSION=latest
FROM ghcr.io/actions/actions-runner:$GITHUB_RUNNER_VERSION
ARG RUST_VERSION=1.77
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
    libmkl-dev \
    libudev-dev \
    libasound2-dev \
    libxcb-composite0-dev \
    libgtk-3-dev \
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

# Install YQ
RUN DPKG_ARCH="$(dpkg --print-architecture)" \
  && YQ_VERSION=$(curl -sL -H "Accept: application/vnd.github+json" https://api.github.com/repos/mikefarah/yq/releases/latest | jq -r '.tag_name' | sed 's/^v//g') \
  && YQ_DOWNLOAD_URL=$(curl -sL -H "Accept: application/vnd.github+json" https://api.github.com/repos/mikefarah/yq/releases/latest | jq ".assets[] | select(.name == \"yq_linux_${DPKG_ARCH}.tar.gz\")" | jq -r '.browser_download_url') \
  && ( curl -s ${YQ_DOWNLOAD_URL} -L -o /tmp/yq.tar.gz && tar -xzf /tmp/yq.tar.gz -C /tmp && sudo mv /tmp/yq_linux_${DPKG_ARCH} /usr/local/bin/yq)

RUN rustup component add clippy rustfmt
RUN cargo install --locked cargo-deny
RUN cargo install cargo-machete
RUN cargo install tomlq

RUN sudo rm -rf /var/lib/apt/lists/*
# modify actions runner binaries to allow custom cache server implementation
RUN sed -i 's/\x41\x00\x43\x00\x54\x00\x49\x00\x4F\x00\x4E\x00\x53\x00\x5F\x00\x43\x00\x41\x00\x43\x00\x48\x00\x45\x00\x5F\x00\x55\x00\x52\x00\x4C\x00/\x41\x00\x43\x00\x54\x00\x49\x00\x4F\x00\x4E\x00\x53\x00\x5F\x00\x43\x00\x41\x00\x43\x00\x48\x00\x45\x00\x5F\x00\x4F\x00\x52\x00\x4C\x00/g' /home/runner/bin/Runner.Worker.dll

USER root
