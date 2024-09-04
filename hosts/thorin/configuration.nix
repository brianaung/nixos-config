{ pkgs, ... }:
{
  imports = [
    ../common.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "thorin"; # Define your hostname.

  modules = {
    users.brianaung = {
      enable = true;
      email = "brianaung16@gmail.com";
      packages = with pkgs; [
        obs-studio
        steam
      ];
    };
    displayServer.wayland = {
      enable = true;
      session = "hyprland";
    };
  };
}
