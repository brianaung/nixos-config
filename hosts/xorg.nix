{ pkgs, ... }:
{
  services.xserver.windowManager.awesome = with pkgs; {
    enable = true;
    # luaModules = [
    #   luaPackages.vicious
    # ];
  };

  services.xserver.displayManager = {
    lightdm.enable = true;
    sessionCommands = ''
      ${pkgs.autorandr}/bin/autorandr -c
    '';
  };

  services.xserver.xkb = {
    layout = "au";
    variant = "";
  };

  # Enable scroll using modifier key.
  services.libinput = {
    enable = true;
    mouse = {
      scrollButton = 3;
      scrollMethod = "button";
    };
  };

  environment.systemPackages = with pkgs; [
    feh
    autorandr
    flameshot
    xclip
    brightnessctl
    pavucontrol
    pasystray
  ];

  programs.nm-applet.enable = true;

  # reload autorandr profile when there is a change in DRM subsystem,
  # does not work with home manager autorandr module
  services.udev.extraRules = ''
    ACTION=="change", SUBSYSTEM=="drm", RUN+="${pkgs.autorandr}/bin/autorandr -c"
  '';

  services.autorandr = {
    enable = true;
    profiles = {
      "docked" = {
        fingerprint = {
          "eDP-1" = "00ffffffffffff0009e5ca0b000000002f200104a51c137803de50a3544c99260f505400000001010101010101010101010101010101115cd01881e02d50302036001dbe1000001aa749d01881e02d50302036001dbe1000001a000000fe00424f452043510a202020202020000000fe004e4531333546424d2d4e34310a0073";
          "DP-4" = "00ffffffffffff0005e30224a40000000d1f010380351e782a0a85aa4f46ab270d5054bfef00d1c081803168317c4568457c6168617c023a801871382d40582c45000f282100001e000000ff004157424d343141303030313634000000fc0032344732573147340a20202020000000fd0030901ea021000a20202020202001d502032ff14c101f0514041303120211013f230907078301000067030c00100000426d1a000002013090e60000000000377f808870381440182035000f282100001e866f80a070384040302035000f282100001efe5b80a070383540302035000f282100001e2a4480a070382740302035000f282100001a000000000000000018";
        };
        config = {
          "eDP-1".enable = false;
          "DP-4" = {
            enable = true;
            primary = true;
            mode = "1920x1080";
            position = "0x0";
            rate = "144.00";
          };
        };
      };
      "undocked" = {
        fingerprint = {
          "eDP-1" = "00ffffffffffff0009e5ca0b000000002f200104a51c137803de50a3544c99260f505400000001010101010101010101010101010101115cd01881e02d50302036001dbe1000001aa749d01881e02d50302036001dbe1000001a000000fe00424f452043510a202020202020000000fe004e4531333546424d2d4e34310a0073";
        };
        config = {
          "eDP-1" = {
            enable = true;
            primary = true;
            mode = "2256x1504";
            position = "0x0";
            rate = "60.00";
          };
        };
      };
    };
    hooks = {
      postswitch = {
        "change-dpi" = ''
          case "$AUTORANDR_CURRENT_PROFILE" in
            docked)
              DPI=100
              ;;
            undocked)
              DPI=144
              ;;
            *)
              echo "Unknow profile: $AUTORANDR_CURRENT_PROFILE"
              exit 1
          esac
          echo "Xft.dpi: $DPI" | ${pkgs.xorg.xrdb}/bin/xrdb -merge
        '';
      };
    };
  };
}
