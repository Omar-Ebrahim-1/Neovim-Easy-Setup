FROM ubuntu:latest

# Update and install necessary packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y neovim git gcc nodejs npm sudo

# Install starship prompt (you may need to replace this with the appropriate method for starship installation on Ubuntu)
RUN sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --yes

# Create a new user and add it to the sudo group
RUN useradd -m -G sudo -s /bin/bash arch && \
    echo "arch ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER arch
WORKDIR /home/arch

# Clone Neovim setup and configure shell
RUN mkdir -p /home/arch/.config && \
    git clone https://github.com/OmarEbrahim1/Neovim_Easy_Setup /home/arch/.config/nvim && \
    mv /home/arch/.config/nvim/.inputrc /home/arch/.inputrc && \
    mv /home/arch/.config/nvim/.bashrc /home/arch/.bashrc

CMD ["/bin/bash"]
