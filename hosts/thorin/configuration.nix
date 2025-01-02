{ pkgs, user, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../common.nix
  ];

  networking.hostName = "thorin"; # Define your hostname.

  users.users.${user} = {
    extraGroups = [ "gamemode" ];
    packages = with pkgs; [
      obs-studio
      discord
    ];
  };

  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;
}
