#!/bin/bash

mkdir -p /usr/local/musl/include

ln -s /usr/include/linux /usr/local/musl/include/linux
ln -s /usr/include/x86_64-linux-gnu/asm /usr/local/musl/include/asm
ln -s /usr/include/asm-generic /usr/local/musl/include/asm-generic

cd /tmp
short_version="$(echo "$OPENSSL_VERSION" | sed s'/[a-z]$//' )"
curl -fLO "https://www.openssl.org/source/openssl-$OPENSSL_VERSION.tar.gz"
    curl -fLO "https://www.openssl.org/source/old/$short_version/openssl-$OPENSSL_VERSION.tar.gz"
tar xvzf "openssl-$OPENSSL_VERSION.tar.gz" && cd "openssl-$OPENSSL_VERSION"
env CC=musl-gcc ./Configure no-shared no-zlib -fPIC --prefix=/usr/local/musl -DOPENSSL_NO_SECURE_MEMORY linux-x86_64
env C_INCLUDE_PATH=/usr/local/musl/include/ make -j$(nproc) depend
env C_INCLUDE_PATH=/usr/local/musl/include/ make -j$(nproc)

make install_sw

rm /usr/local/musl/include/linux /usr/local/musl/include/asm /usr/local/musl/include/asm-generic
rm -r /tmp/*