export ZSH=~/.oh-my-zsh
export PATH=~/.npm-packages/bin:$PATH
export PATH=/usr/local/mysql/bin:$PATH
export SSH_KEY_PATH="~/.ssh/id_ed25519"
export EDITOR=/usr/bin/nvim
export GITLAB_HOST=git.ag.ch

if [ -e /home/karsten/.nix-profile/etc/profile.d/nix.sh ]; then . /home/karsten/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
