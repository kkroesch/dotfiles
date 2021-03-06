
# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="dd.mm.yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(sudo git python docker vagrant terraform colored-man-pages)

source $ZSH/oh-my-zsh.sh

# Key Bindings
# ctrl+b/f or ctrl+left/right : move word by word (backward/forward)
bindkey '^b' backward-word
bindkey '^f' forward-word

# Node.JS tooling
export PATH=~/.npm-packages/bin:$PATH

# MySQL Tools
export PATH=/usr/local/mysql/bin:$PATH

# Script Tools
export PATH=~/.libshell/bin:$PATH

# SSH Agent Tools
export SSH_KEY_PATH="~/.ssh/id_ecdsa"

export JUMPHOST=hjmpsys01.sharedtcs.net
source ~/.libshell/ssh.sh
source ~/.libshell/python.sh
source ~/.libshell/docker.sh
source ~/.libshell/network.sh
source ~/.libshell/currency.sh
source ~/.libshell/macos.sh
source ~/.libshell/crypto.sh
source ~/.libshell/db.sh
source ~/.libshell/vpn.sh

HISTIGNORE="history:fc:ls:la"
HISTORY_IGNORE="(history|ls|cd|fc|la|pwd|exit)"

[ -f $SESSION_FILE ] && ssh-reconnect

# Add additinal functions
fpath=( ~/.zfunc "${fpath[@]}" )

source ~/.alias

# Use zmv: https://coderwall.com/p/yepegw/mass-renaming-files-with-zmv-zsh
autoload -U zmv

# Evaluate .direnv when entering directory
eval "$(direnv hook zsh)"

# CDPATH
setopt auto_cd
cdpath=($HOME/Documents/ $HOME/Projects $HOME/Documents/GitHub $HOME)

# Only works on Mac with iTerm
# test -e ".libshell/iterm2_shell_integration.zsh" && source ".libshell/iterm2_shell_integration.zsh"

# Display host name when logged in remotely
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    PS1="${HOST} $PS1"
fi

# Turn off all beeps
unsetopt BEEP
