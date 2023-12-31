# shell options
setopt AUTO_CD
setopt NO_CASE_GLOB

# starship prompt
eval "$(starship init zsh)"

eval $(opam env)

# vim mode
set -o vi
bindkey -M viins kj vi-cmd-mode

bindkey -s ^f "tmux-sessionizer\n"

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^y' autosuggest-accept
autoload -Uz compinit
compinit
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# completion (trying zsh-autosuggestions now)
# autoload -Uz compinit
# compinit
# zmodload -i zsh/complist
# bindkey -M menuselect '^o' accept-and-infer-next-history
# zstyle ':completion:*:*:*:*:*' menu select
# zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

if [ -n "${commands[fzf-share]}" ]; then
  source "$(fzf-share)/key-bindings.zsh"
  source "$(fzf-share)/completion.zsh"
fi

# aliases
# use exa for prettier ls outputs
alias ls='eza --classify'
alias la='eza --all --classify'
alias ll='eza --long --all --classify'

# nvm installation
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

. "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"

# if tmux is executable and not inside a tmux session, then try to attach.
# if attachment fails, start a new session
# [ -x "$(command -v tmux)" ] \
#   && [ -z "${TMUX}" ] \
#   && { tmux attach || tmux; } >/dev/null 2>&1

# to run my local script
export PATH="$HOME/.local/bin:$PATH"

# add GOPATH
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"

export EDITOR="nvim"
export BROWSER="brave"
