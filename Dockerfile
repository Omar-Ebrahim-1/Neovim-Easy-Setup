FROM archlinux

# Update and install necessary packages
RUN pacman -Syu --noconfirm && \
  pacman -S neovim git gcc nodejs npm --noconfirm
RUN mkdir -p /root/.config
RUN git clone https://github.com/OmarEbrahim1/Neovim_Easy_Setup \
  /root/.config/nvim
RUN echo "Remember to run :Copilot setup in nvim"

WORKDIR /root

CMD ["/bin/bash"]
