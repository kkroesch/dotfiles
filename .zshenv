export ZSH=~/.oh-my-zsh
export SSH_KEY_PATH="~/.ssh/id_ed25519"
export EDITOR=/usr/bin/vi
export GITLAB_HOST=git.ag.ch
export NPM_PACKAGES="$HOME/.npm-packages"
export LIBVIRT_DEFAULT_URI=qemu:///system
export NOTES_DIR=$HOME/Notes
#export SSL_CERT_FILE=~/.config/ssl/root-ca.crt


if [ -e /home/karsten/.nix-profile/etc/profile.d/nix.sh ]; then . /home/karsten/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

# Fixes weird behaviour on remote systems when using Alacritty
export TERM=xterm-256color
. "$HOME/.cargo/env"
