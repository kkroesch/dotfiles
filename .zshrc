
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
plugins=(sudo git python vagrant terraform kubectl )

source $ZSH/oh-my-zsh.sh

# Key Bindings
# ctrl+b/f or ctrl+left/right : move word by word (backward/forward)
bindkey '^b' backward-word
bindkey '^f' forward-word

# Developers tool belt
[ -d $HOME/.npm-packages/bin ] && path+=("$HOME/.npm-packages/bin")
[ -d /go/bin ] && path+=("/go/bin")
path+=("$HOME/.libshell")
path+=("$HOME/.local/bin")
[ -d $HOME/.cargo ] && source "$HOME/.cargo/env"
[ -d /snap/bin ] && path+=('/snap/bin')

# SSH Agent Tools
export SSH_KEY_PATH="~/.ssh/id_id25519"

source ~/.libshell/ssh.sh
[ -f $SESSION_FILE ] && ssh-reconnect

source ~/.libshell/python.sh
source ~/.libshell/network.sh
source ~/.libshell/currency.sh
source ~/.libshell/crypto.sh
source ~/.libshell/vpn.sh

HISTIGNORE="history:fc:ls:la:cd:"
HISTORY_IGNORE="(history|ls|cd|fc|la|pwd|exit)"


# Add additinal functions
fpath=( ~/.zfunc "${fpath[@]}" )

# Manage Aliases
source ~/.alias

# Use zmv: https://coderwall.com/p/yepegw/mass-renaming-files-with-zmv-zsh
autoload -U zmv

# Autocomplete host and domain names from .ssh/config
autoload -Uz compinit
compinit
zstyle ':completion:*:(ssh|scp|sftp|rsync):*' hosts `grep '^Host' ~/.ssh/config | grep -v '[?*]' | cut -d ' ' -f 2- | tr ' ' '\n' | sort -u`

# CDPATH
setopt auto_cd
cdpath=($HOME/Documents/ $HOME/Projects $HOME/Learn $HOME)


# Display host name when logged in remotely
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    PS1="${HOST} $PS1"
fi

# Turn off all beeps
unsetopt BEEP


# Prevent GUI dialog for passphrase:
export GPG_TTY=$(tty)

