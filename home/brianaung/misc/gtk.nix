{ pkgs, ... }: {
  gtk = {
    enable = true;
    font = {
      name = "Fira sans";
      size = 8;
      package = pkgs.fira;
    };
    theme = {
      name = "Pop-dark";
      package = pkgs.pop-gtk-theme;
    };
    iconTheme = {
      name = "Pop";
      package = pkgs.pop-icon-theme;
    };
    # gtk3 = {
    #   extraConfig.gtk-application-prefer-dark-theme = true;
    # };
  };
}
