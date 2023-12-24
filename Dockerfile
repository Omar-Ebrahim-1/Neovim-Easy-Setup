FROM archlinux

# Update and install necessary packages
RUN pacman -Syu --noconfirm && \
  pacman -S neovim git gcc nodejs npm starship \
  sudo fzf --noconfirm

# Create a new user and add it to the sudo group
RUN useradd -m -G wheel -s /bin/bash arch && \
  echo "arch ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER arch
WORKDIR /home/arch

# Clone Neovim setup and configure shell
RUN mkdir -p /home/arch/.config && \
  git clone https://github.com/OmarEbrahim1/Neovim-Easy-Setup /home/arch/.config/nvim && \
  mv /home/arch/.config/nvim/.inputrc /home/arch/.inputrc && \
  mv /home/arch/.config/nvim/.bashrc /home/arch/.bashrc

CMD ["/bin/bash"]
