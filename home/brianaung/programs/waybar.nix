{ config, pkgs, ... }: {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ ];
        modules-right = [
          "network"
          "pulseaudio"
          "battery"
          "clock"
          "tray"
        ];
        "hyprland/workspaces" = {
          disable-scroll = true;
        };
        "clock" = {
          format = "{:%b %d (%a) %I:%M%p}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "month";
            format = {
              today = "<span color='#${config.colors.Blue}'><b><u>{}</u></b></span>";
            };
          };
          actions = {
            on-scroll-up = "shift_up";
            on-scroll-down = "shift_down";
            on-click = "shift_reset";
          };
        };
        "pulseaudio" = {
          tooltip = false;
          format = "[VOL {volume}%]";
          format-muted = "MUT {volume}%";
          scroll-step = 5;
          on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
        };
        "network" = {
          format = "{ifname}";
          tooltip-format = "{ifname} via {gwaddr}";
          on-click = "${pkgs.iwgtk}/bin/iwgtk";
        };
        "battery" = {
          interval = 60;
          format = "[BAT {capacity}%]";
          format-time = "{H}hrs, {M}mins";
          tooltip-format = "{timeTo}";
          states = {
            warning = 30;
            critical = 15;
          };
        };
      };
    };
    style = ''
      * {
        font-family: Terminess Nerd Font;
        font-size: 14px;
        padding: 0;
        border-radius: 0;
      }
      window#waybar {
        background: #${config.colors.Black};
        color: #${config.colors.White};
      }
      #clock,
      #pulseaudio,
      #network,
      #battery,
      #tray,
      #workspaces button {
        color: #${config.colors.White};
        padding: 0 4px;
      }
      #workspaces button.active {
        color: #${config.colors.Black};
        background: #${config.colors.Green};
      }
    '';
  };
}
