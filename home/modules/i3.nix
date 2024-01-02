{ config, pkgs, lib, ... }:

let
	mod = "Mod4";
in with pkgs; {
	xsession.windowManager.i3 = {
		enable = true;
		package = i3;

		config = {
			modifier = mod;

			startup = [
				{ command = "${dex}/bin/dex --autostart --environment i3"; notification = false; }
				{ command = "${xss-lock}/bin/xss-lock --transfer-sleep-lock -- i3lock --nofork"; notification = false; }
				{ command = "${networkmanagerapplet}/bin/nm-applet"; notification = false; }
				{ command = "${pasystray}/bin/pasystray"; notification = false; }
				{ command = "systemctl --user restart dunst.service"; always = true; notification = false; }
				{ command = "${autorandr}/bin/autorandr --change"; always = true; notification = false; }
			];

			focus.followMouse = false;

			floating.modifier = mod;

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

			# use with `lib.mkOptionDefault` if you want to extend on default i3 keybindings
			keybindings = {
				"${mod}+Shift+c" = "reload";
				"${mod}+Shift+r" = "restart";
				"${mod}+Shift+e" = ''
					exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -B 'Yes, exit i3' 'i3-msg exit'"
				'';

				"${mod}+d" = "exec ${dmenu}/bin/dmenu_run";
				"${mod}+Return" = "exec nixGL ${alacritty}/bin/alacritty";

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
				"${mod}+1" = "workspace number 1";
				"${mod}+2" = "workspace number 2";
				"${mod}+3" = "workspace number 3";
				"${mod}+4" = "workspace number 4";
				"${mod}+5" = "workspace number 5";

				# Move workspace
				"${mod}+Shift+1" = "move container to workspace number 1";
				"${mod}+Shift+2" = "move container to workspace number 2";
				"${mod}+Shift+3" = "move container to workspace number 3";
				"${mod}+Shift+4" = "move container to workspace number 4";
				"${mod}+Shift+5" = "move container to workspace number 5";

				"${mod}+f" = "fullscreen toggle";
				"${mod}+Shift+space" = "floating toggle";
				"${mod}+space" = "focus mode_toggle";
				"${mod}+s" = "layout stacking";
				"${mod}+w" = "layout tabbed";
				"${mod}+e" = "layout toggle split";

				# todo: don't use amixer?
				"XF86AudioRaiseVolume" = "exec amixer -q -D pulse sset Master 5%+";
				"XF86AudioLowerVolume" = "exec amixer -q -D pulse sset Master 5%-";
				"XF86AudioMute" = "exec amixer -q -D pulse sset Master toggle";
			};

			bars = [
				{
					position = "top";
					statusCommand = "${i3status}/bin/i3status";
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
		package = i3status;
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

	services.dunst = {
		enable = true;
		package = dunst;

		settings = {
			global = {
				offset = "10x30";
				origin = "top-right";
				font = "JetBrains Mono Nerd Font 9";
				frame_color = "#${config.colorScheme.colors.base03}";
				timeout = 10;
			};

			urgency_low = {
				background = "#${config.colorScheme.colors.base02}";
				foreground = "#${config.colorScheme.colors.base05}";
			};

			urgency_normal = {
				background = "#${config.colorScheme.colors.base0D}";
				foreground = "#${config.colorScheme.colors.base01}";
			};

			urgency_critical = {
				background = "#${config.colorScheme.colors.base08}";
				foreground = "#${config.colorScheme.colors.base01}";
			};
		};
	};
}
