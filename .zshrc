
# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"


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
    ansible
    docker
)

source $ZSH/oh-my-zsh.sh

# Key Bindings
# ctrl+b/f or ctrl+left/right : move word by word (backward/forward)
bindkey '^b' backward-word
bindkey '^f' forward-word

# Developers tool belt

# Node.JS
[ -d $HOME/.npm-packages/bin ] && path+=("$HOME/.npm-packages/bin")
[ -d /opt/node  ] && path+=('/opt/node/bin')

# Go
if [ -d $HOME/go/bin ] 
then
    export GOMODCACHE=$HOME/.gomodcache
    path+=("$HOME/go/bin")
fi

# Rust
[ -d $HOME/.cargo ] && source "$HOME/.cargo/env"

# Python
source ~/.libshell/python.sh
source ~/.libshell/postgres.sh

# Kubernetes
hash kubectl 2>/dev/null && source <(kubectl completion zsh) && alias k="kubectl"

path+=("$HOME/.libshell")
path+=("$HOME/.local/bin")
[ -d /snap/bin ] && path+=('/snap/bin')

# SSH Agent Tools
export SSH_KEY_PATH="~/.ssh/id_ed25519"
source ~/.libshell/ssh.sh
[ -f $SESSION_FILE ] && ssh-reconnect

# Shell history settings
HISTIGNORE="history:fc:ls:la:cd:"
HISTORY_IGNORE="(history|ls|cd|fc|la|pwd|exit)"
unsetopt CORRECT
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="dd.mm.yyyy"

# Add additinal functions
fpath=( ~/.zfunc "${fpath[@]}" )

# Manage Aliases
source ~/.alias

# Use zmv: https://coderwall.com/p/yepegw/mass-renaming-files-with-zmv-zsh
autoload -U zmv

# Turn off all beeps
unsetopt BEEP

# Prevent GUI dialog for passphrase:
export GPG_TTY=$(tty)

# Favour Zoxide over CDPATH
if hash zoxide 2>/dev/null
then
    eval "$(zoxide init --cmd cd zsh)"
else
    setopt auto_cd
    cdpath=($HOME/Documents/ $HOME/Projects $HOME/Learn $HOME)
fi

# Enable Fuzzy Finder (fzf) for searching command line history:
[[ -f /usr/share/fzf/key-bindings.zsh ]] && source /usr/share/fzf/key-bindings.zsh
[[ -f /usr/share/fzf/shell/key-bindings.zsh ]] && source /usr/share/fzf/shell/key-bindings.zsh
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
bindkey '^R' fzf-history-widget

#
# Prompt Manipulation
#

hash starship 2>/dev/null && eval "$(starship init zsh)" && precmd() { echo ""; }

# Display host name when logged in remotely
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    PS1="${HOST} $PS1"
fi

# Handle Toolbox related issues for Fedora Silverblue
if [[ -n "$TOOLBOX_PATH" || "$container" == "oci" ]]; then
  container=$(source /run/.containerenv; echo $name)
  export PS1="[$container] $PS1"
  if [[ "$container" == "kube" ]]
  then
      source ~/kube/kube-ps1.sh && PROMPT='$(kube_ps1)'${PROMPT}
  fi
else
  unalias vi
fi



