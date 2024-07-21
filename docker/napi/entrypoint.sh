#!/bin/sh

cp -r /.ssh ~/.ssh

chown root:root ~/.gitconfig
chown -R root:root ~/.ssh

sed 's|/home/runner|/root|g' -i.bak ~/.ssh/config
chmod -R 600 ~/.ssh

cp /config.toml $CARGO_HOME/config.toml