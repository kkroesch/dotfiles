export ZSH=~/.oh-my-zsh
export SSH_KEY_PATH="~/.ssh/id_ed25519"
export EDITOR=/usr/bin/nvim
export GITLAB_HOST=git.ag.ch
export DOTFILES=$HOME/.dotfiles
export NPM_PACKAGES="$HOME/.npm-packages"
export LIBVIRT_DEFAULT_URI=qemu:///system
export NOTES_DIR=$HOME/Notes


if [ -e /home/karsten/.nix-profile/etc/profile.d/nix.sh ]; then . /home/karsten/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
. "$HOME/.cargo/env"

# Fixes weird behaviour on remote systems when using Alacritty
export TERM=xterm-256color
