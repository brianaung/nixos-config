{ config, pkgs, lib, ... }:

let
	mod = "Mod4";
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
in {
	xsession.windowManager.i3 = {
		enable = true;
		package = pkgs.i3;

		config = {
			modifier = mod;

			terminal = "alacritty";

			startup = [
				# { command = "systemctl --user restart dunst.service"; always = true; notification = false; }

				{ command = "${pkgs.dex}/bin/dex --autostart --environment i3"; notification = false; }
				{ command = "${pkgs.xss-lock}/bin/xss-lock --transfer-sleep-lock -- i3lock --nofork"; notification = false; }
				# { command = "${pkgs.networkmanagerapplet}/bin/nm-applet"; notification = false; }
				{ command = "${pkgs.pasystray}/bin/pasystray"; notification = false; }

				{ command = "${pkgs.autorandr}/bin/autorandr --change"; always = true; notification = false; }
				{ command = "${pkgs.picom}/bin/picom"; notification = false; }

				# run `feh <options> <path-to-wallpaper>` first
				{ command = "sh ~/.fehbg &"; notification = false; }

				{ command = "${pkgs.brave}/bin/brave"; }
				{ command = "${pkgs.alacritty}/bin/alacritty"; }
				{ command = "${pkgs.obsidian}/bin/obsidian"; }
				{ command = "${pkgs.spotify}/bin/spotify"; }
			];

			assigns = {
				${ws1} = [{ class = "^Brave-browser$"; }];
				${ws2} = [{ class = "^Alacritty$"; }];
				${ws3} = [{ class = "^obsidian$"; }];
				${ws10} = [{ class = "^Spotify$"; }];
			};

			window = {
				commands = [
					{ command = "fullscreen enable"; criteria = { class = "^Spotify$"; }; }
					{ command = "fullscreen enable"; criteria = { class = "^obsidian$"; }; }
				];
			};

			floating = {
				modifier = mod;
				criteria = [ { class = "^Pavucontrol$"; } ];
			};

			focus.followMouse = false;

			fonts = {
				names = [ "JetBrains Mono Nerd Font" ];
				style = "Regular";
				size = 9.0;
			};

			colors = {
				background = "#${config.colorScheme.colors.base00}";
				focused = {
					background = "#${config.colorScheme.colors.base0D}";
					border = "#${config.colorScheme.colors.base0D}";
					childBorder = "#${config.colorScheme.colors.base0D}";
					indicator = "#${config.colorScheme.colors.base0D}";
					text = "#${config.colorScheme.colors.base01}";
				};
			};

			# gaps = {
			# 	inner = 4;
			# 	outer = 4;
			# };

			# use with `lib.mkOptionDefault` if you want to extend on default i3 keybindings
			keybindings = {
				"${mod}+Shift+c" = "reload";
				"${mod}+Shift+r" = "restart";
				"${mod}+Shift+e" = ''
					exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -B 'Yes, exit i3' 'xfce4-session-logout'"
				'';

				"${mod}+d" = "exec ${pkgs.dmenu}/bin/dmenu_run";
				"${mod}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";

				"${mod}+q" = "kill";

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

				"${mod}+f" = "fullscreen toggle";
				"${mod}+Shift+space" = "floating toggle";
				"${mod}+space" = "focus mode_toggle";
				"${mod}+s" = "layout stacking";
				"${mod}+w" = "layout tabbed";
				"${mod}+e" = "layout toggle split";
				"${mod}+minus" = "split v";
				"${mod}+equal" = "split h";

				"XF86AudioRaiseVolume" = "exec --no-startup-id pactl set-sink-volume 0 +5%"; #increase sound volume
				"XF86AudioLowerVolume" = "exec --no-startup-id pactl set-sink-volume 0 -5%"; #decrease sound volume
				"XF86AudioMute" = "exec --no-startup-id pactl set-sink-mute 0 toggle"; # mute sound

				# "XF86MonBrightnessUp" = "exec brightnessctl set 5%+"; # increase screen brightness
				# "XF86MonBrightnessDown" = "exec brightnessctl set 5%-"; # decrease screen brightness
			};

			bars = [
				{
					position = "top";
					statusCommand = "${pkgs.i3status}/bin/i3status";
					workspaceButtons = true;
					fonts.size = 9.0;
					colors = {
						background = "#${config.colorScheme.colors.base01}";
						statusline = "#${config.colorScheme.colors.base04}";
						separator = "#${config.colorScheme.colors.base03}";
						focusedWorkspace = {
							background = "#${config.colorScheme.colors.base0D}";
							border = "#${config.colorScheme.colors.base0D}";
							text = "#${config.colorScheme.colors.base02}";
						};
						inactiveWorkspace = {
							background = "#${config.colorScheme.colors.base00}";
							border = "#${config.colorScheme.colors.base03}";
							text = "#${config.colorScheme.colors.base05}";
						};
					};
				}
			];
		};
	};

	programs.i3status = {
		enable = true;
		package = pkgs.i3status;
		enableDefault = false;

		general = {
			colors = true;
			color_good = "#${config.colorScheme.colors.base0B}";
			color_degraded = "#${config.colorScheme.colors.base0A}";
			color_bad = "#${config.colorScheme.colors.base08}";
			interval = 5;
		};

		modules = {
			"disk /" = {
				position = 1;
				settings = {
					format = "Disk: %avail";
				};
			};

			"battery all" = {
				position = 2;
				settings = {
					format = "Battery: %percentage (%status)";
				};
			};

			"load" = {
				position = 3;
				settings = {
					format = "Load: %1min";
				};
			};

			"volume master" = {
				position = 4;
				settings = {
					format = "Volume: %volume";
					format_muted = "muted (%volume)";
					device = "default";
					mixer = "Master";
					mixer_idx = 0;
				};
			};

			"tztime local" = {
				position = 5;
				settings = {
					format = "%d/%m/%y %I:%M%P";
				};
			};
		};
	};

	# services.dunst = {
	# 	enable = true;
	# 	package = pkgs.dunst;

	# 	settings = {
	# 		global = {
	# 			offset = "10x30";
	# 			origin = "top-right";
	# 			font = "JetBrains Mono Nerd Font 9";
	# 			frame_color = "#${config.colorScheme.colors.base03}";
	# 			timeout = 10;
	# 		};

	# 		urgency_low = {
	# 			background = "#${config.colorScheme.colors.base02}";
	# 			foreground = "#${config.colorScheme.colors.base05}";
	# 		};

	# 		urgency_normal = {
	# 			background = "#${config.colorScheme.colors.base0D}";
	# 			foreground = "#${config.colorScheme.colors.base01}";
	# 		};

	# 		urgency_critical = {
	# 			background = "#${config.colorScheme.colors.base08}";
	# 			foreground = "#${config.colorScheme.colors.base01}";
	# 		};
	# 	};
	# };

	# services.udiskie = {
	# 	enable = true;
	# };
}
