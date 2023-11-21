FROM archlinux

# Update and install necessary packages
RUN pacman -Syu --noconfirm && \
  pacman -S neovim git gcc nodejs npm starship --noconfirm
RUN mkdir -p /root/.config
RUN git clone https://github.com/OmarEbrahim1/Neovim_Easy_Setup \
  /root/.config/nvim
RUN mv /root/.config/nvim/.inputrc /root/.inputrc
RUN mv /root/.config/nvim/.bashrc /root/.bashrc

WORKDIR /root

CMD ["/bin/bash"]
