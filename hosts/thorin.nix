{ ... }:
{
  imports = [
    ./common.nix
    ./x11.nix
    ./hardwares/framework-13-7040-amd.nix
  ];

  programs.steam.enable = true;
}
