{ config, lib, pkgs, ... }:
let
  cfg = config.modules.displayServer.wayland;
in
{
  options.modules.displayServer.wayland = {
    enable = lib.mkEnableOption "enable wayland and related modules";
    session = lib.mkOption {
      type = lib.types.enum [ "hyprland" "cosmic" ];
      default = "hyprland";
    };
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
      environment.sessionVariables = {
        NIXOS_OZONE_WL = "1";
      };
    }

    (lib.mkIf (cfg.session == "hyprland") {
      environment.systemPackages = with pkgs; [
        wev # get keyboard, mouse pressed name
        wl-clipboard # clipboard
        libnotify
        brightnessctl
        fuzzel
        cosmic-files
        waybar
        swaynotificationcenter
        networkmanagerapplet
        grim
        slurp
        swappy
        # pavucontrol
      ];

      services.greetd = {
        enable = true;
        settings = {
          default_session = {
            command = "${pkgs.greetd.tuigreet}/bin/tuigreet -t -r --asterisks -c Hyprland";
          };
        };
        vt = 7;
      };

      programs.hyprland.enable = true;
    })

    (lib.mkIf (cfg.session == "cosmic") {
      services.desktopManager.cosmic.enable = true;
      services.displayManager.cosmic-greeter.enable = true;

      nix.settings = {
        substituters = [ "https://cosmic.cachix.org/" ];
        trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
      };
    })
  ]);
}
