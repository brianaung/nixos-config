{ ... }: {
  programs.zsh = {
    enable = true;

    autosuggestion.enable = true;
    enableCompletion = true;

    defaultKeymap = "viins";

    localVariables = {
      ZSH_AUTOSUGGEST_STRATEGY = [
        "history"
        "completion"
      ];
    };

    shellAliases = { };

    initExtra = ''
      KEYTIMEOUT=1
      bindkey '^y' autosuggest-accept
      bindkey -s ^f "tmux-sessionizer\n"
    '';
  };
}
