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
        ls="${pkgs.eza}/bin/eza --classify";
        la="${pkgs.eza}/bin/eza --all --classify";
        ll="${pkgs.eza}/bin/eza --long --all --classify";
    };

    initExtraFirst = ''
			eval "$(${pkgs.fnm}/bin/fnm env --use-on-cd)"
    '';

    initExtra = ''
      bindkey '^y' autosuggest-accept
      bindkey -M viins kj vi-cmd-mode
      source "$(${pkgs.fzf}/bin/fzf-share)/key-bindings.zsh"
      source "$(${pkgs.fzf}/bin/fzf-share)/completion.zsh"
    '';
  };
}
