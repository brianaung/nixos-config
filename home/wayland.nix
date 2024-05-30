{ lib, pkgs, config, ... }:
let
  swayconf = config.wayland.windowManager.sway.config;
  wallpaper = "${config.xdg.configHome}/nixos-config/wallpapers/0";
  swaylock = "${pkgs.swaylock}/bin/swaylock -fF -i ${wallpaper} -s fill";
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
          bg = "${wallpaper} fill";
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
        { workspace = "1"; output = [ "DP-4" "eDP-1" ]; }
        { workspace = "2"; output = [ "DP-4" ]; }
        { workspace = "3"; output = [ "DP-4" ]; }
        { workspace = "4"; output = [ "DP-4" ]; }
        { workspace = "5"; output = [ "DP-4" ]; }
        { workspace = "6"; output = [ "DP-4" ]; }
        { workspace = "7"; output = [ "DP-4" ]; }
        { workspace = "8"; output = [ "DP-4" ]; }
        { workspace = "9"; output = [ "DP-4" ]; }
        { workspace = "10"; output = [ "eDP-1" ]; }
      ];

      # ===== Appearance =====
      window.titlebar = false;

      colors = {
        background = "#${config.colorScheme.palette.base00}";
        focused = {
          background = "#${config.colorScheme.palette.base0A}";
          border = "#${config.colorScheme.palette.base0A}";
          childBorder = "#${config.colorScheme.palette.base0A}";
          indicator = "#${config.colorScheme.palette.base0A}";
          text = "#${config.colorScheme.palette.base00}";
        };
      };

      fonts = {
        names = [ "Terminess Nerd Font" ];
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
          "Print" = ''exec ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp -d)" - | wl-copy'';
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
    backgroundColor = "#${config.colorScheme.palette.base0A}";
    borderColor = "#${config.colorScheme.palette.base02}";
    textColor = "#${config.colorScheme.palette.base02}";
    font = "JetBrainsMono Nerd Font 13";
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
        font-family: Terminess Nerd Font;
        font-size: 20px;
      }
      window#waybar {
        background: #${config.colorScheme.palette.base00};
        color: #${config.colorScheme.palette.base05};
      }
      #battery,
      #clock,
      #cpu,
      #disk,
      #memory,
      #pulseaudio {
        background: #${config.colorScheme.palette.base00};
        color: #${config.colorScheme.palette.base05};
        padding: 0 0.2rem;
      }
      #workspaces button {
        padding: 0 5px;
        background: #${config.colorScheme.palette.base00};
        color: #${config.colorScheme.palette.base05};
      }
      #workspaces button.focused {
        background: #${config.colorScheme.palette.base0A};
        color: #${config.colorScheme.palette.base02};
      }
      #pulseaudio.muted {
        color: #${config.colorScheme.palette.base0A};
      }
      #battery.charging, #battery.plugged {
        color: #${config.colorScheme.palette.base0B};
      }
      #battery.warning:not(.charging),
      #cpu.warning,
      #memory.warning {
        color: #${config.colorScheme.palette.base0A};
      }
      #battery.critical:not(.charging),
      #cpu.critical,
      #memory.critical {
        color: #${config.colorScheme.palette.base08};
      }
    '';
  };

  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "Terminess Nerd Font:size=20";
      };
      colors = {
        background = "ffffffff";
        text = "000000ff";
        selection = "00000022";
        selectionText = "000000aa";
        border = "000000ff";
      };
      border = {
        radius = 0;
      };
    };
  };
}
