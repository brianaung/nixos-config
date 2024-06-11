{ pkgs, ... }:
{
  imports = [
    ./common.nix
    ./hardware/framework-13-7040-amd.nix
  ];

  programs.steam.enable = true;
}
