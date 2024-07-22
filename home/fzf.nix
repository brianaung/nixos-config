{ config, ... }: {
  programs.fzf = {
    enable = true;
    colors = {
      # "bg+" = "#${config.colors.BrightBlack}";
      # bg = "#${config.colors.Black}";
      spinner = "#${config.colors.Blue}";
      hl = "#${config.colors.Yellow}";
      fg = "#${config.colors.White}";
      header = "#${config.colors.Cyan}";
      info = "#${config.colors.Yellow}";
      pointer = "#${config.colors.Red}";
      marker = "#${config.colors.Green}";
      "fg+" = "#${config.colors.BrightWhite}";
      prompt = "#${config.colors.Magenta}";
      "hl+" = "#${config.colors.BrightYellow}";
    };
  };
}
