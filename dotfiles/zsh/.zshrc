# shell options
setopt AUTO_CD
setopt NO_CASE_GLOB

set -o vi
bindkey -M viins kj vi-cmd-mode

eval "$(starship init zsh)"

# tab completion
autoload -Uz compinit
compinit
zmodload -i zsh/complist
bindkey -M menuselect '^o' accept-and-infer-next-history
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

# aliases
# use exa for prettier ls outputs
alias ls='eza --classify'
alias la='eza --all --classify'
alias ll='eza --long --all --classify'

# nvm installation
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

. "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
