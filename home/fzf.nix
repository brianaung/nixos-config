{ config, ... }: {
  programs.fzf = {
    enable = true;
    colors = {
      # "bg+" = "#${config.colorScheme.palette.base01}";
      # bg = "#${config.colorScheme.palette.base00}";
      spinner = "#${config.colorScheme.palette.base0C}";
      hl = "#${config.colorScheme.palette.base0D}";
      fg = "#${config.colorScheme.palette.base04}";
      header = "#${config.colorScheme.palette.base0D}";
      info = "#${config.colorScheme.palette.base0A}";
      pointer = "#${config.colorScheme.palette.base0C}";
      marker = "#${config.colorScheme.palette.base0C}";
      "fg+" = "#${config.colorScheme.palette.base06}";
      prompt = "#${config.colorScheme.palette.base0A}";
      "hl+" = "#${config.colorScheme.palette.base0D}";
    };
  };
}
