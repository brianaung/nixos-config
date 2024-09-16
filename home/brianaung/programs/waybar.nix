{ config, pkgs, ... }: {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [
          "pulseaudio"
          "network"
          "battery"
          "tray"
          "custom/notification"
        ];
        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            default = "";
            active = "";
          };
          disable-scroll = true;
        };
        "clock" = {
          format = "{:%a %b %d %I:%M%p}";
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
          format = "{icon}";
          format-muted = "";
          format-icons = {
            default = [ "" "" "" ];
            headphone = "";
            headset = "";
            phone = "";
            phone-muted = "";
          };
          scroll-step = 5;
          on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
        };
        "network" = {
          format = "{icon}";
          format-disconnected = "󰤭";
          format-disabled = "󰤭";
          format-icons = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
          tooltip-format = "{ifname} via {gwaddr}";
          on-click = "${pkgs.iwgtk}/bin/iwgtk";
        };
        "battery" = {
          interval = 60;
          format = "{capacity}% {icon}";
          format-icons = {
            default = [ "" "" "" "" "" ];
            charging = "";
            plugged = "";
            critical = "";
          };
          format-time = "{H}hrs, {M}mins";
          tooltip-format = "{timeTo}";
          states = {
            warning = 30;
            critical = 15;
          };
        };
        "custom/notification" = {
          tooltip = false;
          format = "";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "swaync-client -t -sw";
          excape = true;
        };
      };
    };
    style = ''
      * {
        font-family: Fira Sans, "Font Awesome 6 Free";
        font-size: 14px;
        border-radius: 5px;
        padding: 0;
      }
      window#waybar {
        background: transparent;
        color: #${config.colors.White};
      }
      .modules-right,
      .modules-center,
      .modules-left {
        background: #${config.colors.Black};
        color: #${config.colors.White};
      }
      .modules-left {
        margin: 5px 0 0 5px;
      }
      .modules-center {
        margin: 5px 0 0 0;
      }
      .modules-right {
        margin: 5px 5px 0 0;
        padding: 0 2px;
      }
      #clock,
      #pulseaudio,
      #network,
      #battery,
      #tray,
      #custom-notification {
        padding: 0 8px;
      }
      #workspaces button {
        color: #${config.colors.BrightBlack};
        font-weight: 900;
        padding: 0 4px;
      }
      #workspaces button.active {
        color: #${config.colors.Green};
        font-weight: 900;
      }
    '';
  };
}
