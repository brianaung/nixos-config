{ pkgs, ... }:
{
  imports = [
    ./common.nix
    ./hardware/framework-13-7040-amd.nix
  ];

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
      wl-clipboard # clipboard
      libnotify
    ];
  };
}
