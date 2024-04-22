# TODO migrate sway config to nix
{ pkgs, config, ... }:
{
  programs.i3status-rust = {
    enable = true;
    bars = {
      default = {
        settings = {
          theme = {
            theme = "plain";
            overrides = {
              idle_bg = "#000000";
              idle_fg = "#ffffff";
            };
          };
        };
        blocks = [
          {
            block = "disk_space";
            format = " DISK $available ";
            interval = 60;
            path = "/";
          }
          {
            block = "load";
            format = " LOAD $1m.eng(w:2) ";
            interval = 5;
          }
          {
            block = "cpu";
            format = " CPU $utilization ";
            interval = 5;
          }
          {
            block = "memory";
            format = " MEM $mem_used_percents.eng(w:2) ";
            interval = 5;
          }
          {
            block = "sound";
            format = " VOL $volume ";
            click = [
              {
                button = "left";
                cmd = "pavucontrol";
              }
            ];
          }
          {
            block = "battery";
            format = " BAT $percentage ($time) ";
            charging_format = " CHR $percentage ";
            interval = 60;
          }
          {
            block = "time";
            format = " $timestamp.datetime(f:'%a %d/%m %I:%M%p') ";
            interval = 60;
          }
        ];
      };
    };
  };

  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "Terminess Nerd Font:size=14";
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
