# dotfiles
Configuration files for SSH and Tmux. Small helpers for daily work on the shell.

## Installation

The most comfortable installation is via Git:

```bash
mkdir Projects
git init --bare Projects/dotfiles.git
git config --global init.defaultBranch master
export DOTFILES=$HOME/Projects/dotfiles.git
cd $DOTFILES
git remote add origin git@github.com:kkroesch/dotfiles.git
cd
echo 'export DOTFILES=$HOME/Projects/dotfiles.git' >> .zshrc
echo 'alias dotfile="git --git-dir=$DOTFILES --work-tree=$HOME"' >> .alias

dotfile config --local status.showUntrackedFiles no  # to ignore all the other stuff in $HOME
dotfile pull origin master
```

Use `dotfile add` and `dotfile commit` to add your own dotfiles.

## Features



## Recommended Font

[Hack Regular Nerd](https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf)
