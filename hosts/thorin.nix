{ pkgs, ... }:
{
  imports = [
    ./common.nix
    ./hardwares/framework-13-7040-amd.nix
  ];

  programs.steam.enable = true;

  programs.river = {
    enable = true;
    extraPackages = with pkgs; [
      sandbar
      bemenu
      kanshi
      acpi
    ];
  };
}
