#!/usr/bin/zsh
# Ensure ZSH_CUSTOM points to the standard location if not already set
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

echo 'You should _source_ this file from zsh'
echo -e "ZSH_CUSTOM path: ${ZSH_CUSTOM}\n"

mkdir -p "${ZSH_CUSTOM}/plugins"

if [[ -d "${ZSH_CUSTOM}/plugins/zsh-autosuggestions" ]]; then
  echo "zsh-autosuggestions already present, skipping clone"
else
  git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM}/plugins/zsh-autosuggestions"
fi
