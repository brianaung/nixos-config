{ pkgs, lib, ... }:
with lib;
{
  imports = [
    ./common.nix
    ./hardware/framework-13-7040-amd.nix
  ];

  # powerManagement.powertop.enable = mkForce true;

  # Set session variables.
  environment.sessionVariables = rec {
    NIXOS_OZONE_WL = "1";
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet -t -r --asterisks -c sway";
      };
    };
    vt = 7;
  };

  programs.sway = {
    enable = true;
    extraPackages = with pkgs; [
      wev # get keyboard, mouse pressed name
      brightnessctl
      pavucontrol
      networkmanagerapplet
      mako # notification
      wl-clipboard # clipboard
      # screenshot
      grim
      slurp
      # screenlock
      swayidle
      swaylock
    ];
  };
}
