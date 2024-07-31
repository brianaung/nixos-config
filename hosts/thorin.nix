{ lib, pkgs, ... }:
{
  imports = [
    ./common.nix
    ./hardwares/framework-13-7040-amd.nix
  ];

  programs.steam.enable = true;

  environment.systemPackages = with pkgs; [
    (dwl.override {
      conf = ../home/dwl/config.h;
    })
    dwl
    dwlb
    somebar
    someblocks
  ];

  # xdg.portal = {
  #   enable = lib.mkDefault true;
  #   wlr.enable = lib.mkDefault true;
  #   extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  #   config.common.default = "*";
  # };
  # services.dbus.enable = true;
  # security.polkit.enable = true;
  # programs.dconf.enable = true;
  # programs.xwayland.enable = true;
  # hardware.opengl.enable = true;
}
