{ config, ... }: {
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "Fira sans:size=14";
      };
      colors = {
        background = "${config.colors.Background}ff";
        text = "${config.colors.Foreground}ff";
        match = "${config.colors.Foreground}aa";
        selection = "${config.colors.Foreground}aa";
        "selection-text" = "${config.colors.Background}ff";
        "selection-match" = "${config.colors.Background}aa";
        border = "${config.colors.Foreground}ff";
      };
    };
  };
}
