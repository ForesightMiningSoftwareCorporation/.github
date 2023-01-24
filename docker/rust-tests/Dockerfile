ARG RUST_VERSION=1.65
FROM rust:$RUST_VERSION

RUN rustup component add clippy rustfmt
RUN cargo install --locked cargo-deny
RUN cargo install cargo-machete

RUN mkdir -p /test-dir

WORKDIR /test-dir
