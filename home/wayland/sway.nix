{
  config,
  lib,
  pkgs,
  ...
}:
{
  wayland.windowManager.sway =
    let
      configPath = "${config.xdg.configHome}/nixos-config/home";
      swayConfig = config.wayland.windowManager.sway.config;
      wallpaper = "${configPath}/wallpapers/0";
      lock = "${pkgs.swaylock}/bin/swaylock -fF -i ${wallpaper} -s fill";
    in
    {
      enable = true;
      checkConfig = false;
      config = {
        menu = "${pkgs.fuzzel}/bin/fuzzel";
        terminal = "${pkgs.alacritty}/bin/alacritty";
        modifier = "Mod1";

        assigns = {
          "1" = [ { app_id = "firefox"; } ];
          "2" = [ { app_id = "Alacritty"; } ];
        };

        bars = [ { command = "${pkgs.waybar}/bin/waybar"; } ];

        window.titlebar = false;

        colors = {
          background = "#${config.colorScheme.palette.base00}";
          focused = {
            background = "#${config.colorScheme.palette.base0A}";
            border = "#${config.colorScheme.palette.base0A}";
            childBorder = "#${config.colorScheme.palette.base0A}";
            indicator = "#${config.colorScheme.palette.base0A}";
            text = "#${config.colorScheme.palette.base01}";
          };
        };

        defaultWorkspace = "workspace number 1";

        floating = {
          criteria = [ { app_id = "pavucontrol"; } ];
        };

        fonts = {
          names = [ "Terminess Nerd Font" ];
          style = "Regular";
          size = 13.0;
        };

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

        startup = [
          { command = "${pkgs.networkmanagerapplet}/bin/nm-applet --indicator"; }
          {
            command = ''
              ${pkgs.swayidle}/bin/swayidle -w \
                timeout 300 ${lock} \
                timeout 600 'systemctl suspend'
            '';
          }
        ];

        workspaceOutputAssign = [
          {
            workspace = "1";
            output = [ "DP-4" ];
          }
          {
            workspace = "2";
            output = [ "DP-4" ];
          }
          {
            workspace = "3";
            output = [ "DP-4" ];
          }
          {
            workspace = "4";
            output = [ "DP-4" ];
          }
          {
            workspace = "5";
            output = [ "DP-4" ];
          }
          {
            workspace = "6";
            output = [ "DP-4" ];
          }
          {
            workspace = "7";
            output = [ "DP-4" ];
          }
          {
            workspace = "8";
            output = [ "DP-4" ];
          }
          {
            workspace = "9";
            output = [ "DP-4" ];
          }
          {
            workspace = "10";
            output = [ "eDP-1" ];
          }
        ];

        left = "h";
        right = "l";
        up = "k";
        down = "j";

        keybindings =
          let
            mod = swayConfig.modifier;
          in
          lib.mkOptionDefault {
            "${mod}+Return" = "exec ${swayConfig.terminal}";
            "${mod}+d" = "exec ${swayConfig.menu}";
            "${mod}+q" = "kill";
            "${mod}+r" = "reload";
            "${mod}+e" = "exec ${lock}";
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
            "XF86MonBrightnessUp" = "exec brightnessctl set 5%+";
            "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
            "Print" = ''exec ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp -d)" - | wl-copy'';
          };
      };
      extraConfig = ''
        bindgesture swipe:right workspace prev
        bindgesture swipe:left workspace next
      '';
    };
}
