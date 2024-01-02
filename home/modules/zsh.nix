{ pkgs, ... }:

{
  programs.zsh = with pkgs; {
    enable = true;
    package = zsh;

    enableAutosuggestions = true;
    enableCompletion = true;

    defaultKeymap = "viins";

    localVariables = {
      ZSH_AUTOSUGGEST_STRATEGY = [ "history" "completion" ];
    };

    shellAliases = {
        ls="${eza}/bin/eza --classify";
        la="${eza}/bin/eza --all --classify";
        ll="${eza}/bin/eza --long --all --classify";
    };

    initExtra = ''
      bindkey '^y' autosuggest-accept
      bindkey -M viins kj vi-cmd-mode
      source "$(${fzf}/bin/fzf-share)/key-bindings.zsh"
      source "$(${fzf}/bin/fzf-share)/completion.zsh"
    '';
  };
}
