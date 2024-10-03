{ config, ... }: {
  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 11;
    };
    settings = {
      background_opacity = "0.9";

      background = "#${config.colors.Black}";
      foreground = "#${config.colors.White}";

      # Black
      color0 = "#${config.colors.Black}";
      color8 = "#${config.colors.BrightBlack}";

      # Red
      color1 = "#${config.colors.Red}";
      color9 = "#${config.colors.BrightRed}";

      # Green
      color2 = "#${config.colors.Green}";
      color10 = "#${config.colors.BrightGreen}";

      # Yellow
      color3 = "#${config.colors.Yellow}";
      color11 = "#${config.colors.BrightYellow}";

      # Blue
      color4 = "#${config.colors.Blue}";
      color12 = "#${config.colors.BrightBlue}";

      # Magenta
      color5 = "#${config.colors.Magenta}";
      color13 = "#${config.colors.BrightMagenta}";

      # Cyan
      color6 = "#${config.colors.Cyan}";
      color14 = "#${config.colors.BrightCyan}";

      # White
      color7 = "#${config.colors.White}";
      color15 = "#${config.colors.BrightWhite}";
    };
  };
}
