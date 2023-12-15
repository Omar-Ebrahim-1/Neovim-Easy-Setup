#!/usr/bin/env sh
set -xe

docker build -t arch_neovim .
docker run -it --name ar arch_neovim
