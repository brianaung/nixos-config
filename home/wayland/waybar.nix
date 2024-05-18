{ config, ... }: {
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
          on-click = "pavucontrol";
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
        padding: 0 0.2rem;
      }
      #workspaces button {
        padding: 0 5px;
        background: #${config.colorScheme.palette.base01};
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
}
