{ pkgs, ... }:
{
  imports = [
    ./common.nix
    ./hardwares/framework-13-7040-amd.nix
  ];

  programs.steam.enable = true;
}
