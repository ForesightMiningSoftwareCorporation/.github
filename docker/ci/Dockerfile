ARG GITHUB_RUNNER_VERSION=latest
FROM myoung34/github-runner:$GITHUB_RUNNER_VERSION
ARG RUST_VERSION=stable

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
    jq
