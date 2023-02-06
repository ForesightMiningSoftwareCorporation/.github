FROM ubuntu:focal AS builder

WORKDIR /usr/src/
ARG OPENSSL_VERSION=1.1.1m

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
  apt-get install \
    -yq --no-install-recommends \
    software-properties-common \
    lsb-release \
    libudev-dev \
    libasound2-dev \
    libxcb-composite0-dev \
    openssh-client \
    wget \
    curl \
    gnupg2 \
    tzdata \
    pkg-config \
    libssl-dev \
    musl-dev \
    musl-tools \
    build-essential \
    cmake \
    curl \
    git \
    gfortran \
    libfontconfig-dev \
    libfreetype-dev \
    libexpat1-dev \
    libmkl-full-dev \
    libomp-8-dev

# Static linking for C++ code
RUN ln -s "/usr/bin/g++" "/usr/bin/musl-g++"

# install Rust
RUN curl https://sh.rustup.rs -sSf | \
    sh -s -- --default-toolchain 1.65 -y -t x86_64-unknown-linux-musl --profile minimal

ENV PATH=/root/.cargo/bin:$PATH
RUN rustup target add x86_64-unknown-linux-musl

# Install OpenSSl
COPY build_openssl_ubuntu.sh build_openssl_ubuntu.sh
RUN ./build_openssl_ubuntu.sh