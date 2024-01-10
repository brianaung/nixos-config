{ config, pkgs, lib, inputs, user, ... }:

{
	imports = [
		inputs.nix-colors.homeManagerModules.default

		./programs/zsh.nix
		./programs/git.nix
		./programs/i3.nix
		./programs/alacritty.nix
		./programs/tmux.nix
		./programs/starship.nix

		./scripts/tmux-sessionizer.nix
	];

	# Most programs will use colors from here, except neovim, for consistency.
	# But it is quick to update neovim as well since I will be using base16 for both.
	colorScheme = inputs.nix-colors.colorSchemes.gruvbox-material-dark-hard;

	home.username = "${user}";
	home.homeDirectory = "/home/${user}";

	home.stateVersion = "23.11";

	home.sessionVariables = {
		EDITOR = "nvim";
		BROWSER = "brave";
		TERMINAL = "alacritty";
	};

	# Install Nix packages into your environment.
	home.packages = with pkgs; [
		brave
		spotify
		dbeaver
		flameshot
		obsidian
		slack

		(nerdfonts.override { fonts = [ "JetBrainsMono" ]; })

		neovim
		fzf
		ripgrep
		fd
		eza
		xclip
		unzip
		ranger

		# todo: i don't know if it's idiomatic to install them globally.
		# fnm
		gnumake
		gcc
		# rustup
	];

	xdg.configFile = {
		# i want to keep this out of nix store because I edit this way too often, that I hate having to keep rebuilding for changes
		"nvim".source = 
			config.lib.file.mkOutOfStoreSymlink "/home/${user}/.config/home-manager/users/${user}/xdg-config/nvim"; # don't use relative path, it will link to nix store

		"ranger" = {
			source = ./xdg-config/ranger;
			recursive = true;
		};
	};

	# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;

	programs.direnv.enable = true;

	programs.zathura = {
		enable = true;
		package = pkgs.zathura;

		options = {
			default-bg = "#${config.colorScheme.colors.base00}";
			default-fg = "#${config.colorScheme.colors.base05}";
		};
	};
}
