{ config, pkgs, ... }:

{
	programs.alacritty = {
		enable = true;
		package = pkgs.alacritty;

		settings = {
			window = {
				opacity = 0.90;
			};

			font = {
				normal = {
					family = "JetBrainsMono Nerd Font";
					style = "Regular";
				};
				bold = {
					family = "JetBrainsMono Nerd Font";
					style = "Bold";
				};
				italic = {
					family = "JetBrainsMono Nerd Font";
					style = "Italic";
				};
				size = 10;
			};

			colors = {
				primary = {
					# background = "#${config.colorScheme.colors.base00}";
					background = "#000000";
					foreground = "#${config.colorScheme.palette.base05}";
				};
				cursor = {
					text = "#${config.colorScheme.palette.base00}";
					cursor = "#${config.colorScheme.palette.base05}";
				};
				normal = {
					black = "#${config.colorScheme.palette.base00}";
					red = "#${config.colorScheme.palette.base08}";
					green = "#${config.colorScheme.palette.base0B}";
					yellow = "#${config.colorScheme.palette.base0A}";
					blue = "#${config.colorScheme.palette.base0D}";
					magenta = "#${config.colorScheme.palette.base0E}";
					cyan = "#${config.colorScheme.palette.base0C}";
					white = "#${config.colorScheme.palette.base05}";
				};
				bright = {
					black = "#${config.colorScheme.palette.base03}";
					red = "#${config.colorScheme.palette.base08}";
					green = "#${config.colorScheme.palette.base0B}";
					yellow = "#${config.colorScheme.palette.base0A}";
					blue = "#${config.colorScheme.palette.base0D}";
					magenta = "#${config.colorScheme.palette.base0E}";
					cyan = "#${config.colorScheme.palette.base0C}";
					white = "#${config.colorScheme.palette.base07}";
				};
			};
		};
	};
}
