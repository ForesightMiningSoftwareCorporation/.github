ARG RUST_VERSION=1.65
FROM rust:$RUST_VERSION

RUN apt-get update && apt-get install -y software-properties-common

RUN apt-add-repository non-free && apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    moreutils \
    libmkl-dev \
    libudev-dev \
    libasound2-dev \
    libxcb-composite0-dev \
    libgtk-3-dev

RUN rustup component add clippy rustfmt
RUN cargo install --locked cargo-deny
RUN cargo install cargo-machete

RUN mkdir -p /test-dir

WORKDIR /test-dir
