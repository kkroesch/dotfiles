# Funktion zum Ausblenden des Prompts
hide_prompt() {
  export POWERLEVEL9K_DISABLE_RPROMPT=true
  unset PROMPT
  zle reset-prompt
}
zle -N hide_prompt

# Funktion zum Einblenden des Prompts
show_prompt() {
  export POWERLEVEL9K_DISABLE_RPROMPT=false
  source ~/.p10k.zsh
  zle reset-prompt
}
zle -N show_prompt

# Tastenkombinationen zuweisen (Strg+P zum Ausblenden, Strg+O zum Einblenden)
bindkey '^P' hide_prompt
bindkey '^O' show_prompt

