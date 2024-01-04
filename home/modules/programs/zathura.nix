{ config, pkgs, ... }:

{
	programs.zathura = {
		enable = true;
		package = pkgs.zathura;

		options = {
			default-bg = "#${config.colorScheme.colors.base00}";
			default-fg = "#${config.colorScheme.colors.base05}";
		};
	};
}
