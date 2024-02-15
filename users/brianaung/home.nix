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
		./programs/zathura.nix

		./scripts/tmux-sessionizer.nix
	];

	# Most programs will use colors from here, except neovim, for consistency.
	# But it is quick to update neovim as well since I will be using base16 for both.
	colorScheme = inputs.nix-colors.colorSchemes.kanagawa;

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
		jetbrains.phpstorm
		thunderbird
		vagrant
		brave
		firefox
		spotify
		dbeaver
		flameshot
		obsidian
		slack
		zoom-us

		(nerdfonts.override { fonts = [ "JetBrainsMono" ]; })

		wezterm

		neovim
		fzf
		ripgrep
		fd
		eza
		xclip
		unzip
		ranger
		lsof

		# i use flake shells sometimes but i m tired setting it up for every projects lol, and takes too long to load sometimes
		gnumake
		gcc
		nodejs_18
		nil
		lua-language-server
		nodePackages.typescript-language-server
		nodePackages.volar
		tailwindcss-language-server
		prettierd
		stylua
	];

	xdg.configFile = {
		# i want to keep this out of nix store because I edit this way too often, that I hate having to keep rebuilding for changes
		"nvim".source = 
			config.lib.file.mkOutOfStoreSymlink "/home/${user}/.config/home-manager/users/${user}/xdg-config/nvim"; # don't use relative path, it will link to nix store

		"wezterm".source = 
			config.lib.file.mkOutOfStoreSymlink "/home/${user}/.config/home-manager/users/${user}/xdg-config/wezterm";

		"ranger" = {
			source = ./xdg-config/ranger;
			recursive = true;
		};
	};

	# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;

	programs.direnv.enable = true;

	xsession.initExtra = ''
		unset XDG_CURRENT_DESKTOP
		unset DESKTOP_SESSION
	'';
}
