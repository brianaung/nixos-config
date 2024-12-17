{ config, ... }: {
  programs.fzf = {
    enable = true;
    defaultOptions = [ "--color 16" ];
    colors = {
      "preview-border" = "#${config.colors.Foreground}";
    };
  };
}
