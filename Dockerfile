FROM archlinux

# Update and install necessary packages
RUN pacman -Syu --noconfirm && \
  pacman -S neovim git gcc nodejs npm starship \
  base-devel sudo --noconfirm

# Create a new user and add it to the sudo group
RUN useradd -m -G wheel -s /bin/bash arch && \
  echo "arch ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
  echo 'MAKEFLAGS="-j$(nproc)"' > /etc/makepkg.conf

USER arch
WORKDIR /home/arch

# Clone Neovim setup and configure shell
RUN mkdir -p /home/arch/.config && \
  git clone https://github.com/OmarEbrahim1/Neovim_Easy_Setup /home/arch/.config/nvim && \
  mv /home/arch/.config/nvim/.inputrc /home/arch/.inputrc && \
  mv /home/arch/.config/nvim/.bashrc /home/arch/.bashrc

# Clone yay and install it
RUN git clone https://aur.archlinux.org/yay-bin.git && \
  cd yay-bin && makepkg -si --noconfirm

CMD ["/bin/bash"]
