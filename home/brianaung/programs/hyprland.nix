{ pkgs, config, ... }: {
  wayland.windowManager.hyprland = {
    enable = true;
    # TODO: slowly move into relevant home manager options
    extraConfig = ''
      ################
      ### MONITORS ###
      ################

      # See https://wiki.hyprland.org/Configuring/Monitors/
      monitor=eDP-1,highrr,0x0,1.6
      monitor=DP-4,highrr,auto,1
      monitor=DP-1,2560x1440@59.951,auto,1

      ###################
      ### MY PROGRAMS ###
      ###################

      # See https://wiki.hyprland.org/Configuring/Keywords/

      # Set programs that you use
      $terminal = ${pkgs.foot}/bin/foot
      $menu = ${pkgs.fuzzel}/bin/fuzzel

      #################
      ### AUTOSTART ###
      #################

      # Autostart necessary processes (like notifications daemons, status bars, etc.)
      # Or execute your favorite apps at launch like this:

      exec-once = waybar &
      exec-once = swaync &
      exec-once = swww-daemon &
      exec-once = hyprmonitor &


      #############################
      ### ENVIRONMENT VARIABLES ###
      #############################

      # See https://wiki.hyprland.org/Configuring/Environment-variables/

      env = XCURSOR_SIZE,24
      env = HYPRCURSOR_SIZE,24


      #####################
      ### LOOK AND FEEL ###
      #####################

      # Refer to https://wiki.hyprland.org/Configuring/Variables/

      # https://wiki.hyprland.org/Configuring/Variables/#general
      general { 
          gaps_in = 3
          gaps_out = 6

          border_size = 2

          # https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
          col.active_border = rgba(${config.colors.Green}ff) rgba(${config.colors.Blue}ff) 45deg
          col.inactive_border = rgba(${config.colors.Black}aa)

          # Set to true enable resizing windows by clicking and dragging on borders and gaps
          resize_on_border = true 

          # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
          allow_tearing = false

          layout = master
      }

      # https://wiki.hyprland.org/Configuring/Variables/#decoration
      decoration {
          rounding = 5

          # Change transparency of focused and unfocused windows
          active_opacity = 1.0
          inactive_opacity = 1.0

          drop_shadow = true
          shadow_range = 4
          shadow_render_power = 3
          col.shadow = rgba(1a1a1aee)

          # https://wiki.hyprland.org/Configuring/Variables/#blur
          blur {
              enabled = true
              size = 5
              passes = 1
              vibrancy = 0.1696
          }
      }

      # https://wiki.hyprland.org/Configuring/Variables/#animations
      animations {
          enabled = true

          # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

          bezier = myBezier, 0.05, 0.9, 0.1, 1.05

          animation = windows, 1, 7, myBezier
          animation = windowsOut, 1, 7, default, popin 80%
          animation = border, 1, 10, default
          animation = borderangle, 1, 8, default
          animation = fade, 1, 7, default
          animation = workspaces, 1, 6, default
      }

      # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
      master {
          new_is_master = true
          new_on_top = true
      }

      # https://wiki.hyprland.org/Configuring/Variables/#misc
      misc { 
          force_default_wallpaper = 0 # Set to 0 or 1 to disable the anime mascot wallpapers
          disable_hyprland_logo = true # If true disables the random hyprland logo / anime girl background. :(
      }


      #############
      ### INPUT ###
      #############

      # https://wiki.hyprland.org/Configuring/Variables/#input
      input {
          kb_layout = au
          kb_variant =
          kb_model =
          kb_options =
          kb_rules =

          follow_mouse = 1

          sensitivity = 0 # -1.0 - 1.0, 0 means no modification.

          scroll_method = on_button_down
          scroll_button = 273
          scroll_factor = 0.5

          touchpad {
              natural_scroll = false
          }
      }

      # https://wiki.hyprland.org/Configuring/Variables/#gestures
      gestures {
          workspace_swipe = true
      }

      # Example per-device config
      # See https://wiki.hyprland.org/Configuring/Keywords/#per-device-input-configs for more
      device {
          name = epic-mouse-v1
          sensitivity = -0.5
      }


      ####################
      ### KEYBINDINGSS ###
      ####################

      # See https://wiki.hyprland.org/Configuring/Keywords/
      $MODKEY = Alt

      # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
      bind = $MODKEY SHIFT, RETURN, exec, $terminal
      bind = $MODKEY, Q, killactive,
      bind = $MODKEY SHIFT, E, exit,
      bind = $MODKEY, P, exec, $menu

      bind = $MODKEY, SPACE, togglefloating,
      bind = $MODKEY, F, fullscreen,

      # Move focus with MODKEY + arrow keys
      # bind = $MODKEY, left, movefocus, l
      # bind = $MODKEY, right, movefocus, r
      # bind = $MODKEY, up, movefocus, u
      # bind = $MODKEY, down, movefocus, d

      # Move focus
      bind = $MODKEY, J, layoutmsg, cyclenext
      bind = $MODKEY, K, layoutmsg, cycleprev
      bind = $MODKEY, RETURN, layoutmsg, swapwithmaster
      binde = $MODKEY, L, resizeactive, 50 0
      binde = $MODKEY, H, resizeactive, -50 0

      # Switch workspaces with MODKEY + [0-9]
      bind = $MODKEY, 1, workspace, 1
      bind = $MODKEY, 2, workspace, 2
      bind = $MODKEY, 3, workspace, 3
      bind = $MODKEY, 4, workspace, 4
      bind = $MODKEY, 5, workspace, 5
      bind = $MODKEY, 6, workspace, 6
      bind = $MODKEY, 7, workspace, 7
      bind = $MODKEY, 8, workspace, 8
      bind = $MODKEY, 9, workspace, 9
      bind = $MODKEY, 0, workspace, 10

      # Move active window to a workspace with MODKEY + SHIFT + [0-9]
      bind = $MODKEY SHIFT, 1, movetoworkspace, 1
      bind = $MODKEY SHIFT, 2, movetoworkspace, 2
      bind = $MODKEY SHIFT, 3, movetoworkspace, 3
      bind = $MODKEY SHIFT, 4, movetoworkspace, 4
      bind = $MODKEY SHIFT, 5, movetoworkspace, 5
      bind = $MODKEY SHIFT, 6, movetoworkspace, 6
      bind = $MODKEY SHIFT, 7, movetoworkspace, 7
      bind = $MODKEY SHIFT, 8, movetoworkspace, 8
      bind = $MODKEY SHIFT, 9, movetoworkspace, 9
      bind = $MODKEY SHIFT, 0, movetoworkspace, 10

      # Example special workspace (scratchpad)
      # bind = $MODKEY, S, togglespecialworkspace, magic
      # bind = $MODKEY SHIFT, S, movetoworkspace, special:magic

      # Scroll through existing workspaces with MODKEY + scroll
      # bind = $MODKEY, mouse_down, workspace, e+1
      # bind = $MODKEY, mouse_up, workspace, e-1

      # Move windows with MODKEY + LMB and dragging
      bindm = $MODKEY, mouse:272, movewindow

      # Media keys
      bindel = ,XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+
      bindel = ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
      bindl = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      bindel = ,XF86MonBrightnessUp, exec, brightnessctl set 5%+
      bindel = ,XF86MonBrightnessDown, exec, brightnessctl set 5%-
      bind = ,Print, exec, grim -g "$(slurp -d)" - | swappy -f -


      ##############################
      ### WINDOWS AND WORKSPACES ###
      ##############################

      # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
      # See https://wiki.hyprland.org/Configuring/Workspace-Rules/ for workspace rules

      windowrule = float, ^(pavucontrol)$
      windowrule = float, (.*)(iwgtk)(.*)
      windowrule = float, ^(.blueman-manager-wrapped)$

      windowrulev2 = suppressevent maximize, class:.* # You'll probably like this.
    '';
  };

  # services.hypridle = {
  #   enable = true;
  #   settings = {
  #     general = {
  #       after_sleep_cmd = "hyprctl dispatch dpms on";
  #       ignore_dbus_inhibit = false;
  #       lock_cmd = "hyprlock";
  #     };

  #     listener = [
  #       {
  #         timeout = 900;
  #         on-timeout = "hyprlock";
  #       }
  #       {
  #         timeout = 1200;
  #         on-timeout = "hyprctl dispatch dpms off";
  #         on-resume = "hyprctl dispatch dpms on";
  #       }
  #     ];
  #   };
  # };

  programs.hyprlock.enable = true;
}
