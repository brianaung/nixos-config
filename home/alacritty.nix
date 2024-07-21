{ config, ... }: {
  programs.alacritty = {
    enable = true;

    settings = {
      # window = {
      #   opacity = 0.9;
      # };
      font = {
        normal = {
          family = "SF Mono";
          style = "Regular";
        };
        bold = {
          family = "SF Mono";
          style = "Semibold";
        };
        italic = {
          family = "SF Mono";
          style = "Regular Italic";
        };
        size = 16.0;
      };

      colors = {
        primary = {
          background = "#${config.colors.Black}";
          foreground = "#${config.colors.White}";
        };
        cursor = {
          text = "#${config.colors.Black}";
          cursor = "#${config.colors.White}";
        };
        normal = {
          black = "#${config.colors.Black}";
          red = "#${config.colors.Red}";
          green = "#${config.colors.Green}";
          yellow = "#${config.colors.Yellow}";
          blue = "#${config.colors.Blue}";
          magenta = "#${config.colors.Magenta}";
          cyan = "#${config.colors.Cyan}";
          white = "#${config.colors.White}";
        };
        bright = {
          black = "#${config.colors.BrightBlack}";
          red = "#${config.colors.BrightRed}";
          green = "#${config.colors.BrightGreen}";
          yellow = "#${config.colors.BrightYellow}";
          blue = "#${config.colors.BrightBlue}";
          magenta = "#${config.colors.BrightMagenta}";
          cyan = "#${config.colors.BrightCyan}";
          white = "#${config.colors.BrightWhite}";
        };
      };
    };
  };
}
