{ config, pkgs, lib, ... }:

let
	mod = "Mod4";
in {
	xsession.windowManager.i3 = {
		enable = true;
		package = pkgs.i3;

		config = {
			modifier = mod;

			fonts = {
				name = [ "JetBrains Mono Nerd Font" ];
				style = "Regular";
				size = 9.0;
			};

			keybindings = lib.mkOptionDefault {
				"${mod}+Shift+c" = "reload";
				"${mod}+Shift+r" = "restart";

				"${mod}+d" = "exec ${pkgs.dmenu}/bin/dmenu_run";
				"${mod}+Return" = "exec nixGL ${pkgs.alacritty}/bin/alacritty";

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

				"${mod}+-" = "split h";
				"${mod}+=" = "split v";

				"${mod}+f" = "fullscreen toggle";
				"${mod}+Shift+space" = "floating toggle";
				"${mod}+space" = "focus mode_toggle";
				"${mod}+s" = "layout stacking";
				"${mod}+t" = "layout tabbed";
				"${mod}+e" = "layout toggle split";
			};

			focus.followMouse = false;

			floating.modifier = mod;
		};
	};
}
