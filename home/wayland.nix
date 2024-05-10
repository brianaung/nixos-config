{ pkgs, config, ... }:
let
  mkOutOfStoreSymlink = config.lib.file.mkOutOfStoreSymlink;
  configPath = "${config.xdg.configHome}/nixos-config/home";
in
{
  imports = [
    ./common.nix
    ./i3status.nix
    ./fuzzel.nix
  ];

  xdg.configFile = {
    sway.source = mkOutOfStoreSymlink "${configPath}/sway";
  };

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
