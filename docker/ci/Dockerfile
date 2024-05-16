ARG GITHUB_RUNNER_VERSION=latest
FROM ghcr.io/actions/actions-runner:$GITHUB_RUNNER_VERSION
ARG RUST_VERSION=1.77
ARG SCCACHE_VERSION=0.7.7

# Ubuntu Repo Management
RUN sudo apt-get update && sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    software-properties-common \
    curl
# Install GH Cli repo
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
    && sudo chmod 644 /usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && sudo chmod 644 /etc/apt/sources.list.d/github-cli.list
# Install kubectl repo
RUN curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /usr/share/keyrings/kubernetes-apt-keyring.gpg \
    && sudo chmod 644 /usr/share/keyrings/kubernetes-apt-keyring.gpg \
    && echo 'deb [signed-by=/usr/share/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list \
    && sudo chmod 644 /etc/apt/sources.list.d/kubernetes.list
# Install NodeJS v20 repo
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -

RUN sudo apt-get update && sudo apt-get install -y -qq --no-install-recommends \
    zip \
    wget \
    postgresql \
    gnupg \
    tar \
    gpg-agent \
    gettext \
    wget \
    dirmngr \
    locales \
    rsync \
    pkg-config \
    moreutils \
    jq \
    nodejs \
    gh \
    kubectl

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --profile minimal --default-toolchain $RUST_VERSION -y
ENV PATH="/home/runner/.cargo/bin:${PATH}"

# Install sccache
RUN wget https://github.com/mozilla/sccache/releases/download/v$SCCACHE_VERSION/sccache-v$SCCACHE_VERSION-x86_64-unknown-linux-musl.tar.gz \
    && tar xzf sccache-v$SCCACHE_VERSION-x86_64-unknown-linux-musl.tar.gz \
    && sudo mv sccache-v$SCCACHE_VERSION-x86_64-unknown-linux-musl/sccache /usr/local/bin/sccache \
    && sudo chmod +x /usr/local/bin/sccache

RUN sudo rm -rf /var/lib/apt/lists/*

# modify actions runner binaries to allow custom cache server implementation
RUN sed -i 's/\x41\x00\x43\x00\x54\x00\x49\x00\x4F\x00\x4E\x00\x53\x00\x5F\x00\x43\x00\x41\x00\x43\x00\x48\x00\x45\x00\x5F\x00\x55\x00\x52\x00\x4C\x00/\x41\x00\x43\x00\x54\x00\x49\x00\x4F\x00\x4E\x00\x53\x00\x5F\x00\x43\x00\x41\x00\x43\x00\x48\x00\x45\x00\x5F\x00\x4F\x00\x52\x00\x4C\x00/g' /home/runner/bin/Runner.Worker.dll

USER root
