{ config, ... }: {
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "Fira sans:size=14";
      };
      colors = {
        background = "${config.colors.Black}ff";
        text = "${config.colors.White}ff";
        match = "${config.colors.BrightWhite}ff";
        selection = "${config.colors.White}ff";
        "selection-text" = "${config.colors.Black}ff";
        "selection-match" = "${config.colors.BrightWhite}ff";
        border = "${config.colors.Black}ff";
      };
    };
  };
}
