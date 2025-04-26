{ pkgs, user, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../common.nix
  ];

  networking.hostName = "thorin"; # Define your hostname.

  users.users.${user} = {
    packages = with pkgs; [
      obs-studio
    ];
  };
}
