# dotfiles
Configuration files for SSH and Tmux. Small helpers for daily work on the shell.

## Installation

The most comfortable installation is via Git:

```bash
mkdir $HOME/Projects  
export DOTFILES=$HOME/Projects/dotfiles.git # Or choose any other preferred location
git init --bare $DOTFILES
cd $DOTFILES
git config init.defaultBranch master
git remote add origin git@github.com:kkroesch/dotfiles.git
cd
# For convenience, add:
echo 'export DOTFILES=$HOME/Projects/dotfiles.git' >> .zshrc
echo 'alias dotfile="git --git-dir=$DOTFILES --work-tree=$HOME"' >> .alias
dotfile config --local status.showUntrackedFiles no  # to ignore all the other stuff in $HOME

# Finally, get the stuff:
dotfile pull origin master
```

Use `dotfile add` and `dotfile commit` to add your own dotfiles.

## Features



## Recommended Font

[Hack Regular Nerd](https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf)

## Neovim Plugin Manager 

To make use of the Neovim plugin configs, install the Neovim Plugin Manager:

```
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim 
```

In Neovim, execute `:PluginInstall`.


