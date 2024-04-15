ARG GITHUB_RUNNER_VERSION=latest
FROM myoung34/github-runner:$GITHUB_RUNNER_VERSION
ARG RUST_VERSION=1.77
ARG SCCACHE_VERSION=0.7.7

# Bring latest postgres
RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
RUN wget -qO- https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo tee /etc/apt/trusted.gpg.d/pgdg.asc &>/dev/null

RUN apt-get update && apt-get install -y software-properties-common build-essential curl make gcc libpq-dev wget postgresql

# Install sccache
RUN wget https://github.com/mozilla/sccache/releases/download/v$SCCACHE_VERSION/sccache-v$SCCACHE_VERSION-x86_64-unknown-linux-musl.tar.gz \
    && tar xzf sccache-v$SCCACHE_VERSION-x86_64-unknown-linux-musl.tar.gz \
    && mv sccache-v$SCCACHE_VERSION-x86_64-unknown-linux-musl/sccache /usr/local/bin/sccache \
    && chmod +x /usr/local/bin/sccache


ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH \
    RUST_VERSION=$RUST_VERSION

RUN curl --proto '=https' --tlsv1.2 -sSf https://static.rust-lang.org/rustup/dist/x86_64-unknown-linux-gnu/rustup-init > rustup-init && \
    curl --proto '=https' --tlsv1.2 -sSf https://static.rust-lang.org/rustup/dist/x86_64-unknown-linux-gnu/rustup-init.sha256 > rustup-init.sha256 && \
    sed -i "s|target/x86_64-unknown-linux-gnu/release/||g" rustup-init.sha256 && \
    sha256sum -c rustup-init.sha256 && \
    rm rustup-init.sha256 && \
    chmod u+x rustup-init && \
    ./rustup-init -y --default-toolchain $RUST_VERSION && \
    rm rustup-init

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
    moreutils \
    libmkl-dev \
    libudev-dev \
    libasound2-dev \
    libxcb-composite0-dev \
    libgtk-3-dev \
    jq

RUN apt-get install -y \
    software-properties-common \
    npm

RUN npm install npm@latest -g && \
    npm install n -g && \
    n latest

RUN rustup component add clippy rustfmt
RUN cargo install --locked cargo-deny
RUN cargo install cargo-machete
RUN cargo install tomlq

ARG ADDITIONAL_CMD
RUN $ADDITIONAL_CMD
