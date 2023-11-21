#! /bin/bash
sudo pacman -S --noconfirm neovim

# install LaTeX
sudo pacman -S --noconfirm texlive-basic texlive-binextra texlive-latexextra \
  texlive-mathscience latexmk

# custom script
lua ./setup/setup.lua

# install lsp
sudo pacman -S --noconfirm nodejs npm
sudo npm -i -g pyright
