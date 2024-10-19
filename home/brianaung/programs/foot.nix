{ config, ... }: {
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "Terminess Nerd Font:size=13";
        dpi-aware = "no";
      };
      colors = {
        background = "${config.colors.Background}";
        foreground = "${config.colors.Foreground}";

        # Black
        regular0 = "${config.colors.Black}";
        bright0 = "${config.colors.BrightBlack}";

        # Red
        regular1 = "${config.colors.Red}";
        bright1 = "${config.colors.BrightRed}";

        # Green
        regular2 = "${config.colors.Green}";
        bright2 = "${config.colors.BrightGreen}";

        # Yellow
        regular3 = "${config.colors.Yellow}";
        bright3 = "${config.colors.BrightYellow}";

        # Blue
        regular4 = "${config.colors.Blue}";
        bright4 = "${config.colors.BrightBlue}";

        # Magenta
        regular5 = "${config.colors.Magenta}";
        bright5 = "${config.colors.BrightMagenta}";

        # Cyan
        regular6 = "${config.colors.Cyan}";
        bright6 = "${config.colors.BrightCyan}";

        # White
        regular7 = "${config.colors.White}";
        bright7 = "${config.colors.BrightWhite}";
      };
    };
  };
}
