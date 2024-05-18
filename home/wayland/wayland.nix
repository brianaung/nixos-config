{ pkgs, ... }:
{
  imports = [
    ../common.nix
    ./sway.nix
    ./waybar.nix
    ./fuzzel.nix
  ];

  gtk = {
    enable = true;
    theme = {
      name = "Breeze-Dark";
      package = pkgs.libsForQt5.breeze-gtk;
    };
    gtk3 = {
      extraConfig.gtk-application-prefer-dark-theme = true;
    };
  };
}
