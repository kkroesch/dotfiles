# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(sudo git docker django)

source $ZSH/oh-my-zsh.sh

# Node.JS tooling
export PATH=~/.npm-packages/bin:$PATH

# SSH Agent Tools
export SSH_KEY_PATH="~/.ssh/id_ecdsa"

export JUMPHOST=hjmpsys01.sharedtcs.net
source ~/.libshell/ssh.sh

# Python
source ~/.libshell/python.sh
source ~/.libshell/docker.sh

source ~/.libshell/proxy.sh

source ~/.libshell/currency.sh

# CDPATH
setopt auto_cd
cdpath=($HOME/Documents/ $HOME/Documents/GitHub $HOME)

