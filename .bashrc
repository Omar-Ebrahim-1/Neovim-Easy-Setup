#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Setting vi mode for Bash
set -o vi
export EDITOR='vi'
export VISUAL='vi'

# Bash Prompt
PS1='[\u@\h \W]\$ '

# Keybindings
bind -x '"\el": "ls"'

# Docker Aliases
alias di='docker images'
alias dls='docker ps -a'
alias drmi='docker rmi'
dbu ()
{
    echo "Enter image name: "
    read image_name
    docker build -t $image_name .
}
de ()
{
    docker exec -it $1 /bin/bash
}
drm ()
{
    docker stop $1
    docker rm $1
}
dps ()
{
    docker tag $1 "omarebrahim1/$1"
    docker push "omarebrahim1/$1"
}
dr ()
{
    echo "Enter port to run on: "
    read final_port
    echo "Enter port to map to: "
    read map_port
    echo "Enter image name: "
    read image_name
    docker run -p $final_port:$map_port -d $image_name
}

# Terraform Aliases
alias tfi='terraform init'
alias tff='terraform fmt'
alias tfa='terraform apply'
alias tfd='terraform destroy'
alias tfs='terraform show'
alias tfp='terraform plan'

# Cyberbot Aliases
alias mcb='sudo mount /dev/sdb /mnt/Cyberbot'
alias ecb='sudo eject /dev/sdb'
alias cbm='sudo mv cyberbot.hex /mnt/Cyberbot/'
alias cbl='ls /mnt/Cyberbot/'

# Git Aliases
alias gi='git clone'
alias gc='git add . && git commit -m'
alias gl='git log --oneline --graph --decorate --all'
alias gu='git reset --hard'
alias gt='git tag'
alias gm='git merge'
alias gsw='git switch'
alias gst='git status'
alias gb='git branch'
alias gd='git diff'
alias gps='git push origin main'
alias gpl='git pull origin main'

# Tar Aliases
alias taru='tar -xvf'
alias tarz='tar -cvf'

# Make Aliases
alias mkr='make run'
alias mkt='make test'

# Command Shortcuts
alias c='clear'
alias '..'='cd ..'
alias nv='cd ~/.config/nvim && nvim'
alias es='nvim ~/.config/espanso/match/base.yml'
alias ba='cd ~ && nvim .bashrc && cd -'
alias sba='cd ~ && source .bashrc && cd -'
alias cleardownloads='rm -rf ~/Downloads/*'

# Storage Aliases
alias mountusb='sudo mount /media/backup_usb'
alias ejectusb='sudo umount /media/backup_usb'
alias backusb='sudo rsync -aAXv --delete --exclude=/dev/* --exclude=/proc/* --exclude=/sys/* --exclude=/tmp/* --exclude=/run/* --exclude=/mnt/* --exclude=/media/* --exclude="swapfile" --exclude="lost+found" --exclude=".cache" --exclude=".VirtualBoxVMs" / /media/backup_usb'

alias mounthdd='sudo mount /mnt/external_hdd'
alias ejecthdd='sudo umount /mnt/external_hdd'
alias backhdd='sudo rsync -aAXv --delete --exclude=/dev/* --exclude=/proc/* --exclude=/sys/* --exclude=/tmp/* --exclude=/run/* --exclude=/mnt/* --exclude=/media/* --exclude="swapfile" --exclude="lost+found" --exclude=".cache" --exclude=".VirtualBoxVMs" / /mnt/external_hdd/Nov'

# Colored Commands
alias ls='ls --color=auto'
alias g='grep --color=auto'

# Pacman Aliases
alias pi='sudo pacman -S '
alias pss='sudo pacman -Ss'
alias pr='sudo pacman -Rns '
alias pq='sudo pacman -Qev'
update() {
  echo "Please insert USB and press enter"
  read -r
  mountusb
  backusb
  ejectusb
  sudo eject /dev/sdb
  echo $(date) >> ~/Random/pacman.txt
  sudo pacman -Syu --ignore *tex* --ignore libreoffice* --noconfirm >> ~/Random/pacman.txt
  echo "Press leaderpu to update neovim. Press enter to continue"
  read -r
  nvim
}

# Starship addon
eval "$(starship init bash)"

# Network
fixwlan0() {
    sudo rfkill unblock 1 && sudo ip link set wlan0 up
}

# Fzf
pf() {
  local dir
  cd $HOME && dir=$(find . -type d -not -path '*/\.*' | fzf +m --ansi) && cd "$dir"
}

pn() {
  local file
  cd "$HOME" || return  # Go to the $HOME directory

  file=$(fzf --preview 'bat --style=numbers --color=always {}' --preview-window=up:50%:wrap)

  if [[ -n $file ]]; then
    nvim "$file"
  fi
}

po() {
  local file
  cd "$HOME" || return  # Go to the $HOME directory

  file=$(fzf --preview 'bat --style=numbers --color=always {}' --preview-window=up:50%:wrap)

  if [[ -n $file ]]; then
    okular "$file"
  fi
}
# Templates
courseinit(){
    cat ~/Random/course_readme_template.md > README.md
    read -p "Enter course name: " course_name
    read -p "Enter course id: " course_id
    term="Fall"
    year="2023"
    sed -i "s/Course_Name/$course_name/g" README.md
    sed -i "s/Course_ID/$course_id/g" README.md
    sed -i "s/Term/$term/g" README.md
    sed -i "s/Year/$year/g" README.md
}
latexinit(){
    cat ~/Recent\ documents/Random_Information/LaTeX/LaTeX_Template.tex > Report.tex
    cat ~/Random/LaTeX_gitignore_template.txt > .gitignore
    read -p "Instructor First Name: " first_name
    read -p "Instructer Last Name: " last_name
    read -p "Report Title: " report_title
    sed -i "s/First/$first_name/g" Report.tex
    sed -i "s/Last/$last_name/g" Report.tex
    sed -i "s/Title/$report_title/g" Report.tex
}
pyenv(){
    python -m venv .venv
    source .venv/bin/activate
}
pyinit(){
    helpers_main=$'\n\n\ndef main():\n\n\nif __name__ == "__main__":\n    main()'
    main=$'import helpers as h\n\n\ndef main():\n\n\nif __name__ == "__main__":\n    main()'
    test="import $1\n\n\ndef test_$1():\n    assert $1.main() is None"

    python -m venv .venv
    source .venv/bin/activate

    echo -e "[pycodestyle]\nignore = W391" > setup.cfg
    echo -e ".venv\nsetup.cfg\nBacklog.md\n__pycache__ " > .gitignore
    cat ~/Random/README_Python_Template.md > README.md
    touch $1.py helpers.py Makefile test_$1.py setup.py
    mkdir docs

    echo -e "$main" >> $1.py
    echo -e "$helpers_main" >> helpers.py
    echo -e "$test" >> test_$1.py

    sed -i "s/project_name/$1/g" README.md
}

# Created by `pipx` on 2023-07-12 14:27:12
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.cabal/bin:$HOME/.ghcup/bin:$PATH"
export EDITOR=/usr/bin/nvim
