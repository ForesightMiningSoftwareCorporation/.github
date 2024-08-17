FROM rust:alpine

ENV PATH="/aarch64-linux-musl-cross/bin:/usr/local/cargo/bin/rustup:/root/.cargo/bin:$PATH" \
    RUSTFLAGS="-C target-feature=-crt-static" \
    CC="clang" \
    CXX="clang++" \
    GN_EXE=gn

RUN apk add --update --no-cache \
  nodejs \
  yarn \
  bash \
  clang \
  wget \
  cmake \
  git \
  openssh \
  make \
  perl \
  pkgconfig \
  openssl-dev \
  curl \
  gcc \
  musl-dev \
  linux-headers \
  libudev-dev \
  libasound2-dev \
  libxcb-composite0-dev \
  libgtk-3-dev


WORKDIR /tmp

RUN curl -fLO "https://www.openssl.org/source/openssl-1.1.1m.tar.gz"
RUN tar xvzf "openssl-1.1.1m.tar.gz"
WORKDIR /tmp/openssl-1.1.1m
RUN ./config -fPIC
RUN make -j$(nproc) depend
RUN make -j$(nproc)
RUN make -j$(nproc) install_sw

ENV OPENSSL_LIB_DIR=/usr/local/lib
ENV OPENSSL_INCLUDE_DIR=/usr/include/openssl
ENV OPENSSL_STATIC=yes

WORKDIR /build

RUN mkdir /ssh

COPY config.toml /config.toml
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT /entrypoint.sh
