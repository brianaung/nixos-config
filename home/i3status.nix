{ config, ... }:
{
  programs.i3status = {
    enable = true;
    enableDefault = false;
    general = {
      colors = true;
      color_good = "#${config.colorScheme.palette.base0B}";
      color_degraded = "#${config.colorScheme.palette.base0A}";
      color_bad = "#${config.colorScheme.palette.base08}";
      interval = 5;
    };
    modules = {
      "disk /" = {
        position = 1;
        settings = {
          format = "DISK %avail";
        };
      };
      "load" = {
        position = 2;
        settings = {
          format = "LOAD %1min";
          max_threshold = "3";
        };
      };
      "cpu_usage" = {
        position = 3;
        settings = {
          format = "CPU %usage";
        };
      };
      "memory" = {
        position = 4;
        settings = {
          format = "MEM %percentage_used";
          threshold_degraded = "20%";
          threshold_critical = "10%";
        };
      };
      "volume master" = {
        position = 5;
        settings = {
          format = "VOL %volume";
          format_muted = "MUTED %volume";
          device = "default";
        };
      };
      "battery all" = {
        position = 6;
        settings = {
          format = "%status %percentage %consumption %remaining";
          low_threshold = "30";
          threshold_type = "percentage";
        };
      };
      "time" = {
        position = 7;
        settings = {
          format = "%a %d/%m %I:%M%p";
        };
      };
    };
  };
}
