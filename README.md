# dotfiles
Configuration files for SSH and Tmux. Small helpers for daily work on the shell.

## Installation

The most comfortable installation is via Git:

```bash
mkdir Projects
git init --bare Projects/dotfiles.git
git config --global init.defaultBranch master
git remote add origin git@github.com:kkroesch/dotfiles.git

export DOTFILES=$HOME/Projects/dotfiles.git
alias dotfile='git --git-dir=$DOTFILES --work-tree=$HOME'   # <-- save this in .alias!

dotfile config --local status.showUntrackedFiles no  # to ignore all the other stuff in $HOME
dotfile pull origin master
```

Use `git add` and `git commit` to add your own dotfiles.

## Features



## Recommended Font

[Hack Regular Nerd](https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf)
