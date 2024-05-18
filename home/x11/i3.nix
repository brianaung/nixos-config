{ config
, pkgs
, ...
}:
let
  mod = "Mod1";
  ws1 = "1";
  ws2 = "2";
  ws3 = "3";
  ws4 = "4";
  ws5 = "5";
  ws6 = "6";
  ws7 = "7";
  ws8 = "8";
  ws9 = "9";
  ws10 = "10";
in
{
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = mod;

      defaultWorkspace = "workspace number ${ws1}";

      startup = [
        {
          command = "${pkgs.picom}/bin/picom -b";
          notification = false;
        }
        {
          command = "${pkgs.xss-lock}/bin/xss-lock --transfer-sleep-lock -- i3lock --nofork";
          notification = false;
        }
        {
          command = "xcape";
          notification = false;
        }
        {
          command = "${pkgs.autorandr}/bin/autorandr --change";
          always = true;
          notification = false;
        }
        {
          command = "sh ~/.fehbg &";
          notification = false;
        }
        { command = "${pkgs.firefox}/bin/firefox"; }
        { command = "${pkgs.alacritty}/bin/alacritty"; }
      ];

      assigns = {
        ${ws1} = [{ class = "^firefox$"; }];
        ${ws2} = [{ class = "^Alacritty$"; }];
      };

      fonts = {
        names = [ "Terminess Nerd Font" ];
        style = "Regular";
        size = 9.0;
      };

      gaps = {
        inner = 4;
        outer = 2;
      };

      window = {
        border = 1;
        titlebar = false;
      };

      colors = {
        background = "#${config.colorScheme.palette.base00}";
        focused = {
          background = "#${config.colorScheme.palette.base0D}";
          border = "#${config.colorScheme.palette.base0D}";
          childBorder = "#${config.colorScheme.palette.base0D}";
          indicator = "#${config.colorScheme.palette.base0D}";
          text = "#${config.colorScheme.palette.base01}";
        };
      };

      # use with `lib.mkOptionDefault` if you want to extend on default i3 keybindings
      keybindings = {
        "${mod}+Shift+e" = "exec --no-startup-id i3-msg exit";
        "${mod}+r" = "reload";
        "${mod}+Shift+r" = "restart";
        "${mod}+q" = "kill";
        "${mod}+d" = "exec ${pkgs.dmenu}/bin/dmenu_run -i";

        # Applications
        "${mod}+Return" = "exec i3-sensible-terminal";
        "${mod}+b" = "exec ${pkgs.firefox}/bin/firefox";

        # Focus window
        "${mod}+h" = "focus left";
        "${mod}+j" = "focus down";
        "${mod}+k" = "focus up";
        "${mod}+l" = "focus right";

        # Move window
        "${mod}+Shift+h" = "move left";
        "${mod}+Shift+j" = "move down";
        "${mod}+Shift+k" = "move up";
        "${mod}+Shift+l" = "move right";

        # Switch workspace
        "${mod}+1" = "workspace number ${ws1}";
        "${mod}+2" = "workspace number ${ws2}";
        "${mod}+3" = "workspace number ${ws3}";
        "${mod}+4" = "workspace number ${ws4}";
        "${mod}+5" = "workspace number ${ws5}";
        "${mod}+6" = "workspace number ${ws6}";
        "${mod}+7" = "workspace number ${ws7}";
        "${mod}+8" = "workspace number ${ws8}";
        "${mod}+9" = "workspace number ${ws9}";
        "${mod}+0" = "workspace number ${ws10}";

        # Move workspace
        "${mod}+Shift+1" = "move container to workspace number ${ws1}";
        "${mod}+Shift+2" = "move container to workspace number ${ws2}";
        "${mod}+Shift+3" = "move container to workspace number ${ws3}";
        "${mod}+Shift+4" = "move container to workspace number ${ws4}";
        "${mod}+Shift+5" = "move container to workspace number ${ws5}";
        "${mod}+Shift+6" = "move container to workspace number ${ws6}";
        "${mod}+Shift+7" = "move container to workspace number ${ws7}";
        "${mod}+Shift+8" = "move container to workspace number ${ws8}";
        "${mod}+Shift+9" = "move container to workspace number ${ws9}";
        "${mod}+Shift+0" = "move container to workspace number ${ws10}";

        # layouts
        "${mod}+f" = "fullscreen toggle";
        "${mod}+Shift+space" = "floating toggle";
        "${mod}+space" = "focus mode_toggle";
        "${mod}+s" = "layout stacking";
        "${mod}+w" = "layout tabbed";
        "${mod}+e" = "layout toggle split";
        "${mod}+minus" = "split v";
        "${mod}+equal" = "split h";

        # Audio controls
        "XF86AudioRaiseVolume" = "exec --no-startup-id wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+";
        "XF86AudioLowerVolume" = "exec --no-startup-id wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
        "XF86AudioMute" = "exec --no-startup-id wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";

        "Print" = "exec ${pkgs.flameshot}/bin/flameshot gui";

        # Brightness controls
        "XF86MonBrightnessUp" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 5%+";
        "XF86MonBrightnessDown" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 5%-";
      };

      bars = [
        {
          position = "top";
          statusCommand = "${pkgs.i3status}/bin/i3status";
          fonts = {
            names = [ "Terminess Nerd Font" ];
            style = "Regular";
            size = 13.0;
          };
          colors = {
            background = "#${config.colorScheme.palette.base00}";
            statusline = "#${config.colorScheme.palette.base05}";
            separator = "#${config.colorScheme.palette.base03}";
            focusedWorkspace = {
              background = "#${config.colorScheme.palette.base0D}";
              border = "#${config.colorScheme.palette.base0D}";
              text = "#${config.colorScheme.palette.base02}";
            };
            inactiveWorkspace = {
              background = "#${config.colorScheme.palette.base01}";
              border = "#${config.colorScheme.palette.base03}";
              text = "#${config.colorScheme.palette.base05}";
            };
          };
        }
      ];
    };
  };
}
