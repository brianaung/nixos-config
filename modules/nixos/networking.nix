{ config, lib, pkgs, ... }:
let
  cfg = config.modules.networking;
in
{
  options.modules.networking = {
    iwd.enable = lib.mkEnableOption "enable iwd";
    networkmanager.enable = lib.mkEnableOption "enable networkmanager";
  };

  config = {
    assertions = [
      {
        assertion = !(cfg.iwd.enable && cfg.networkmanager.enable);
        message = "conflicting network services";
      }
    ];

    networking.wireless.iwd.enable = cfg.iwd.enable;

    # Enable networking.
    networking.networkmanager.enable = cfg.networkmanager.enable; # Enable networking
    programs.nm-applet.enable = cfg.networkmanager.enable; # only works in x11
    environment.systemPackages = lib.mkIf cfg.networkmanager.enable [
      pkgs.networkmanager # only needed in wayland
    ];
  };
}
