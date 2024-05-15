# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="robbyrussell"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="dd.mm.yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    sudo 
    git 
    python 
    golang 
    kubectl
    systemd
)

source $ZSH/oh-my-zsh.sh

# Key Bindings
# ctrl+b/f or ctrl+left/right : move word by word (backward/forward)
bindkey '^b' backward-word
bindkey '^f' forward-word

# Developers tool belt

# Node.JS
[ -d $HOME/.npm-packages/bin ] && path+=("$HOME/.npm-packages/bin")

# Go
if [ -d $HOME/go/bin ] 
then
    export GOMODCACHE=$HOME/.gomodcache
    path+=("$HOME/go/bin")
fi

# Rust
[ -d $HOME/.cargo ] && source "$HOME/.cargo/env"

path+=("$HOME/.libshell")
path+=("$HOME/.local/bin")
[ -d /snap/bin ] && path+=('/snap/bin')
[ -d /opt/vscode  ] && path+=('/opt/vscode/bin')
[ -d /opt/node  ] && path+=('/opt/node/bin')

[ -d '/usr/local/cuda-12.3/bin' ] && path+=('/usr/local/cuda-12.3/bin')

# SSH Agent Tools
export SSH_KEY_PATH="~/.ssh/id_id25519"

source ~/.libshell/ssh.sh
[ -f $SESSION_FILE ] && ssh-reconnect

source ~/.libshell/python.sh
export PYTHONSTARTUP=$HOME/.pythonrc.py

source ~/.libshell/network.sh
source ~/.libshell/postgres.sh

HISTIGNORE="history:fc:ls:la:cd:"
HISTORY_IGNORE="(history|ls|cd|fc|la|pwd|exit)"


# Add additinal functions
fpath=( ~/.zfunc "${fpath[@]}" )

# Manage Aliases
source ~/.alias

# Use zmv: https://coderwall.com/p/yepegw/mass-renaming-files-with-zmv-zsh
autoload -U zmv

# CDPATH
#setopt auto_cd
#cdpath=($HOME/Documents/ $HOME/Projects $HOME/Learn $HOME)


# Display host name when logged in remotely
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    PS1="${HOST} $PS1"
fi

if [ -n "$IN_NIX_SHELL" ]
then
    PS1="[Nix] $PS1"
fi


# Turn off all beeps
unsetopt BEEP

# Prevent GUI dialog for passphrase:
export GPG_TTY=$(tty)

eval "$(zoxide init --cmd cd zsh)"

# Enable Fuzzy Finder (fzf) for searching command line history:
source /usr/share/fzf/shell/key-bindings.zsh
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
bindkey '^R' fzf-history-widget

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
