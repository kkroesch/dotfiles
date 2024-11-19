# dotfiles

Dotfiles for application configuration and shell scripts to ease the daily work
on the command line. Applications covered are ZSH with Oh-my-ZSH and
Powerlevel10k, Neovim, (Neo)mutt, Tmux, Ansible, Nix-Shell, jq, Ranger and Podman.

## Installation

Some packages are needed beforehand so all the scripts and tools will work:

```bash
sudo dnf install lsd fzf podman dnf-plugins-core git-delta corkscrew
```

Without the Dotfiles installed, you have the "chicken-egg-problem". While the
installation can easily be performed via Ansible (playbooks are located in
`.ansible/playbooks`) on additional machines, the initial installation process
looks like:

```bash
mkdir $HOME/.dotfiles  
export DOTFILES=$HOME/.dotfiles.git # Or choose any other preferred location
git init --bare $DOTFILES
cd $DOTFILES
git config init.defaultBranch master
git remote add origin git@github.com:kkroesch/dotfiles.git
cd
# For convenience, add:
echo 'export DOTFILES=${DOTFILES}' >> .zshenv
echo 'alias dotfile="git --git-dir=$DOTFILES --work-tree=$HOME"' >> .alias
dotfile config --local status.showUntrackedFiles no  # to ignore all the other stuff in $HOME

# Finally, get the stuff:
dotfile pull origin main
```

Use `dotfile add` and `dotfile commit` to add your own dotfiles.

## Features

 - 

## Optional

Use [Powerlevel10k](https://github.com/romkatv/powerlevel10k):

```
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc
```

## Recommended Font

[Hack Regular Nerd](https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf)

## Neovim Plugin Manager 

To make use of the Neovim plugin configs, install the Neovim Plugin Manager:

```
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim 
```

In Neovim, execute `:PluginInstall`.


