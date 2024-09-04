{ config, pkgs, ... }: {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        modules-left = [
          "hyprland/workspaces"
        ];
        modules-center = [ "clock" ];
        modules-right = [
          "pulseaudio"
          # "network"
          "battery"
          "tray"
          "custom/notification"
        ];
        "hyprland/workspaces" = {
          disable-scroll = true;
        };
        "clock" = {
          tooltip = false;
          format = "{:%a %b %d %I:%M%p}";
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
        # "network" = {
        #   format = "{icon}";
        #   format-disconnected = "󰤭";
        #   format-icons = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
        # };
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
        font-family: Fira sans;
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
        padding: 0 5px;
      }
      .modules-right {
        margin: 5px 5px 0 0;
        padding: 0 5px;
      }
      #pulseaudio,
      #battery,
      #tray,
      #custom-notification {
        padding: 0 10px;
      }
      #workspaces button {
        padding: 0 5px;
      }
      #workspaces button.active {
        background: #${config.colors.White};
        color: #${config.colors.Black};
      }
    '';
  };
}
