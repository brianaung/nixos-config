{ lib, pkgs, config, ... }:
let
  swayconf = config.wayland.windowManager.sway.config;
  # wallpaper = "${config.xdg.configHome}/nixos-config/wallpapers/4";
  # swaylock = "${pkgs.swaylock}/bin/swaylock -fF -i ${wallpaper} -s fill";
  swaylock = "${pkgs.swaylock}/bin/swaylock -fF -c ${config.colors.Black} -s fill";
in
{
  gtk = {
    enable = true;
    theme = {
      name = "Breeze-Dark";
      package = pkgs.libsForQt5.breeze-gtk;
    };
    gtk3 = {
      extraConfig.gtk-application-prefer-dark-theme = true;
    };
  };

  services.swayidle = {
    enable = true;
    timeouts = [
      { timeout = 300; command = swaylock; }
      { timeout = 900; command = "${pkgs.systemd}/bin/systemctl suspend"; }
    ];
  };

  wayland.windowManager.sway = {
    enable = true;
    checkConfig = false;
    config = {
      modifier = "Mod1";
      menu = "${pkgs.fuzzel}/bin/fuzzel";
      terminal = "${pkgs.alacritty}/bin/alacritty";

      # ===== IO =====
      input = {
        "type:pointer" = {
          pointer_accel = "0.5";
          scroll_factor = "0.5";
          scroll_button = "273";
          scroll_method = "on_button_down";
        };
        "type:touchpad" = {
          tap = "enabled";
          scroll_factor = "0.2";
        };
      };

      output = {
        "*" = {
          bg = "#${config.colors.Black} solid_color";
        };
        eDP-1 = {
          mode = "2256x1504@59.999Hz";
          pos = "0 0";
          scale = "1.25";
        };
        DP-4 = {
          mode = "1920x1080@144.000Hz";
          pos = "2256 0";
          scale = "0.8";
        };
        DP-1 = {
          mode = "2560x1440@59.951Hz";
          pos = "2256 0";
          scale = "1";
        };
        HDMI-A-1 = {
          mode = "1920x1080@120.000Hz";
          pos = "2256 0";
          scale = "1";
        };
      };

      # ===== Programs =====
      startup = [
        { command = "${pkgs.networkmanagerapplet}/bin/nm-applet --indicator"; }
      ];

      bars = [{ command = "${pkgs.waybar}/bin/waybar"; }];

      floating = {
        criteria = [{ app_id = "pavucontrol"; }];
      };

      # ===== Workspaces =====
      defaultWorkspace = "workspace number 1";

      assigns = {
        "1" = [{ app_id = "firefox"; }];
        "2" = [{ app_id = "Alacritty"; }];
      };

      workspaceOutputAssign = [
        { workspace = "1"; output = [ "DP-4" "DP-1" "HDMI-A-1" "eDP-1" ]; }
        { workspace = "2"; output = [ "DP-4" "DP-1" "HDMI-A-1" ]; }
        { workspace = "3"; output = [ "DP-4" "DP-1" "HDMI-A-1" ]; }
        { workspace = "4"; output = [ "DP-4" "DP-1" "HDMI-A-1" ]; }
        { workspace = "5"; output = [ "DP-4" "DP-1" "HDMI-A-1" ]; }
        { workspace = "6"; output = [ "DP-4" "DP-1" "HDMI-A-1" ]; }
        { workspace = "7"; output = [ "DP-4" "DP-1" "HDMI-A-1" ]; }
        { workspace = "8"; output = [ "DP-4" "DP-1" "HDMI-A-1" ]; }
        { workspace = "9"; output = [ "DP-4" "DP-1" "HDMI-A-1" ]; }
        { workspace = "10"; output = [ "eDP-1" ]; }
      ];

      # ===== Appearance =====
      window.titlebar = false;

      # gaps = {
      #   inner = 8;
      #   outer = 4;
      # };

      colors = {
        background = "#${config.colors.Black}";
        focused = {
          background = "#${config.colors.Magenta}";
          border = "#${config.colors.Magenta}";
          childBorder = "#${config.colors.Magenta}";
          indicator = "#${config.colors.Magenta}";
          text = "#${config.colors.Black}";
        };
      };

      fonts = {
        names = [ "SF Mono" ];
        style = "Regular";
        size = 13.0;
      };

      # ===== Keybindings =====
      left = "h";
      right = "l";
      up = "k";
      down = "j";
      keybindings =
        let
          mod = swayconf.modifier;
        in
        lib.mkOptionDefault {
          "${mod}+Return" = "exec ${swayconf.terminal}";
          "${mod}+d" = "exec ${swayconf.menu}";
          "${mod}+q" = "kill";
          "${mod}+r" = "reload";
          "${mod}+e" = "exec ${swaylock}";
          "${mod}+Shift+e" = "exec swaymsg exit";

          "${mod}+f" = "fullscreen toggle";
          "${mod}+Shift+space" = "floating toggle";
          "${mod}+space" = "focus mode_toggle";
          "${mod}+s" = "layout stacking";
          "${mod}+w" = "layout tabbed";
          "${mod}+t" = "layout toggle split";
          "${mod}+minus" = "split v";
          "${mod}+equal" = "split h";

          "XF86AudioRaiseVolume" = "exec wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+";
          "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
          "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          "XF86MonBrightnessUp" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 5%+";
          "XF86MonBrightnessDown" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 5%-";
          "Print" = ''exec ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp -d)" - | ${pkgs.swappy}/bin/swappy -f -'';
        };
    };
    extraConfig = ''
      bindgesture swipe:right workspace prev
      bindgesture swipe:left workspace next
    '';
  };

  services.mako = {
    enable = true;
    defaultTimeout = 10000;
    backgroundColor = "#${config.colors.White}";
    borderColor = "#${config.colors.Black}";
    textColor = "#${config.colors.Black}";
    font = "SF Mono 13";
    height = 200;
    width = 500;
  };

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        modules-left = [
          "sway/workspaces"
          "sway/mode"
          "wlr/taskbar"
          "disk"
          "cpu"
          "memory"
        ];
        modules-center = [ "sway/window" ];
        modules-right = [
          "pulseaudio"
          "battery"
          "clock"
          "tray"
        ];
        "cpu" = {
          tooltip = false;
          interval = 15;
          format = "[CPU {usage}%]";
          states = {
            warning = 50;
            critical = 80;
          };
        };
        "memory" = {
          tooltip = false;
          interval = 30;
          format = "[MEM {percentage}%]";
          states = {
            warning = 50;
            critical = 80;
          };
        };
        "disk" = {
          tooltip = false;
          interval = 60;
          format = "[DISK {free}]";
        };
        "battery" = {
          interval = 60;
          format = "[BAT {capacity}%]";
          format-time = "{H}hrs, {M}mins";
          states = {
            warning = 30;
            critical = 15;
          };
        };
        "clock" = {
          tooltip = false;
          format = "{:%a %b %d %I:%M%p}";
        };
        "pulseaudio" = {
          tooltip = false;
          format = "[VOL {volume}%]";
          format-muted = "[MUT {volume}%]";
          scroll-step = 5;
          on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
        };
        "sway/workspaces" = {
          disable-scroll = true;
        };
        "wlr/taskbar" = {
          on-click = "activate";
        };
      };
    };
    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: SF Mono;
        font-size: 18px;
      }
      window#waybar {
        background: #${config.colors.Black};
        color: #${config.colors.White};
      }
      #battery,
      #clock,
      #cpu,
      #disk,
      #memory,
      #pulseaudio {
        background: #${config.colors.Black};
        color: #${config.colors.White};
        padding: 0 0.2rem;
      }
      #workspaces button {
        padding: 0 5px;
        background: #${config.colors.Black};
        color: #${config.colors.Magenta};
      }
      #workspaces button.focused {
        background: #${config.colors.Magenta};
        color: #${config.colors.Black};
      }
      #pulseaudio.muted {
        color: #${config.colors.Yellow};
      }
      #battery.charging, #battery.plugged {
        color: #${config.colors.Green};
      }
      #battery.warning:not(.charging),
      #cpu.warning,
      #memory.warning {
        color: #${config.colors.Yellow};
      }
      #battery.critical:not(.charging),
      #cpu.critical,
      #memory.critical {
        color: #${config.colors.Red};
      }
    '';
  };

  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "SF Mono:size=18";
      };
      colors = {
        background = "${config.colors.White}ff";
        text = "${config.colors.Black}ff";
        match = "${config.colors.BrightBlack}ff";
        selection = "${config.colors.Black}ff";
        "selection-text" = "${config.colors.White}ff";
        "selection-match" = "${config.colors.BrightBlack}ff";
        border = "${config.colors.Black}ff";
      };
      border = {
        radius = 0;
      };
    };
  };
}
