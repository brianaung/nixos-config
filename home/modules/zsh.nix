{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    package = pkgs.zsh;

    enableAutosuggestions = true;
    enableCompletion = true;

    defaultKeymap = "viins";

    localVariables = {
      ZSH_AUTOSUGGEST_STRATEGY = [ "history" "completion" ];
    };

    shellAliases = {
        ls="eza --classify";
        la="eza --all --classify";
        ll="eza --long --all --classify";
    };

    initExtra = ''
      bindkey '^y' autosuggest-accept
      bindkey -M viins kj vi-cmd-mode
      source "$(fzf-share)/key-bindings.zsh"
      source "$(fzf-share)/completion.zsh"
    '';
  };
}
