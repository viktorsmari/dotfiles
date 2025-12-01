#!/bin/bash

ensure_installed() {
  if ! command -v gum &> /dev/null; then
    echo "gum could not be found, installing gum..."
    sudo apt-get install -y gum
  fi

  if ! command -v git &> /dev/null; then
    echo "git could not be found, installing git..."
    sudo apt-get install -y git
  fi

  if ! command -v stow &> /dev/null; then
    echo "stow could not be found, installing stow..."
    sudo apt-get install -y stow
  fi

  if ! command -v curl &> /dev/null; then
    echo "curl could not be found, installing curl..."
    sudo apt-get install -y curl
  fi
}

ensure_installed

echo "Cloning repo and linking configs..."
if [ -d ~/dotfiles ]; then
  echo "Directory ~/dotfiles already exists. Not cloning repo again!"
else
  echo "Cloning i3 repo..."
  git clone https://github.com/viktorsmari/dotfiles.git ~/dotfiles
fi

cd ~/dotfiles || exit
# print out current directory
echo "Current directory: $(pwd)"

mkdir -p ~/Pictures/screenshots

picked=$(
  printf '%s\n' \
    "apt dependencies" "sway" "i3" "oh-my-zsh" "neovim + plugins" \
    "vim + plugins" "mise" "git config" \
  | gum choose --no-limit --selected "sway" --selected "mise" \
  --header "Select what to install (SPACE to toggle):"
) || exit 1

grep -Fxq "sway" <<<"$picked"             && USE_SWAY=y
grep -Fxq "i3" <<<"$picked"               && USE_I3=y
grep -Fxq "apt dependencies" <<<"$picked" && USE_DEP=y
grep -Fxq "oh-my-zsh" <<<"$picked"        && USE_OHMZ=y
grep -Fxq "neovim + plugins" <<<"$picked" && USE_NEOVIM=y
grep -Fxq "vim + plugins" <<<"$picked"    && USE_VIM=y
grep -Fxq "mise" <<<"$picked"             && USE_MISE=y
grep -Fxq "git config" <<<"$picked"       && USE_GIT=y

#echo "i3=$USE_I3 deps=$USE_DEP ohmyzsh=$USE_OHMZ neovim=$USE_NEOVIM vim=$USE_VIM mise=$USE_MISE git=$USE_GIT"

if [[ $USE_DEP = 'y' ]]; then
  echo -e "======== Install programs ========\n"

  sudo apt-get update

  # VIP packages
  sudo apt-get install -y curl nmap zsh g++ automake make \
    tree htop whois thunar bmon \
    btop \
    alacritty \
    vim-gtk3 \
    vim \
    libyaml-dev \
    nm-tray

  # Packages for Wayland
  sudo apt-get install -y wl-clipboard \
    grim grimshot \
    wf-recorder

  sudo apt-get install -y silversearcher-ag pwgen powerline \
    postgresql postgresql-contrib libpq-dev \
    inotify-tools jq ncdu \
    fuzzel \
    i3status \
    libpq-dev zlib1g-dev

  # Packages for X
  sudo apt-get install -y xbacklight xclip \
    xfce4-clipman rofi flameshot arandr
fi

if [[ $USE_SWAY = 'y' ]]; then
  #echo "installing sway"
  sudo apt install -y sway
fi

if [[ $USE_I3 = 'y' ]]; then
  sudo apt-get install -y i3

  # Link i3 status bar
  ln -s ~/dotfiles/i3status.conf ~/.i3status.conf
  ln -s ~/dotfiles/i3blocks.conf ~/.i3blocks.conf

  # Create the first config
  ~/dotfiles/generatei3.sh
fi

if [[ $USE_GIT = 'y' ]]; then
  echo "1b. What is your email? (For git config)"
  read -p 'Email: ' MY_EMAIL
  read -p 'User name: ' MY_USER

  echo -e "\n======== Setup git ========\n"
  git config --global core.editor "vim"
  git config --global merge.conflictstyle diff3
  git config --global merge.tool vimdiff
  git config --global mergetool.prompt false
  git config --global pull.rebase true
  git config --global push.default matching
  git config --global push.followTags true
  git config --global user.email $MY_EMAIL
  git config --global user.name $MY_USER
fi


if [[ $USE_OHMZ = 'y' ]]; then
  echo -e "\n======== Setup oh-my-zsh ========\n"
  echo -e "Remember to check if there is a newer way of installing oh-my-zsh?\n"

  #TODO (fails): Change default shell to ZSH
  sudo chsh -s /bin/zsh

  # install oh my zsh
  sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  # link my zsh config
  stow zsh

  echo -e "\ncloning zsh-autosuggestions... did not work the last time!\n"
  #git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  source ~/dotfiles/scripts/install_zsh-autosuggestions.sh

  echo -e "\nYou must add it to .zshrc plugins()"
fi

if [[ $USE_MISE = 'y' ]]; then
  echo -e "\n======== Setup mise ========\n"
  curl https://mise.run | sh
  echo 'eval "$(~/.local/bin/mise activate zsh)"' >> ~/.zshrc
fi

if [[ $USE_NEOVIM = 'y' ]]; then
  echo -e "======== Setup neovim ========\n"
  sudo apt-get install -y neovim
  mkdir ~/.config/nvim
  stow nvim

  echo -e "installing plug for nvim...\n"
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  # Install plugins
  nvim -c 'PlugInstall' -c 'qa!'
fi

if [[ $USE_VIM = 'y' ]]; then
  echo -e "\n======== Setup vim ========\n"

  # Get Vundle, Vim plugin manager
  git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

  stow vim

  # Get vim color scheme monokai
  mkdir -p ~/.vim/colors
  wget https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim -P ~/.vim/colors
  wget https://raw.githubusercontent.com/sickill/vim-monokai/master/colors/monokai.vim -P ~/.vim/colors

  # Install plugins
  vim -c 'PluginInstall' -c 'qa!'
fi

echo -e 'All done!\n'
