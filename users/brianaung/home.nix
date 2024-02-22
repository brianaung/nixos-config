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
		thunderbird
		vagrant
		brave
		firefox
		spotify
		flameshot
		obsidian
		slack
		zathura

		(nerdfonts.override { fonts = [ "JetBrainsMono" ]; })

		neovim
		fzf
		ripgrep
		fd
		eza
		xclip
		unzip
		lsof

		# Usually I use either flakes or docker for dev environment, but I want them globally installed atm
		gnumake
		gcc
		php83
		nodejs_18
		nil
		lua-language-server
		phpactor
		nodePackages.typescript-language-server
		nodePackages.volar
		tailwindcss-language-server
		prettierd
		stylua
		php83Packages.php-cs-fixer
	];

	xdg.configFile = {
		# i like to keep these out of nix store personally since I update them way too often, dont care about reproducibility much
		# don't use relative path, it will link to nix store (is there a better way?)
		"nvim".source = 
			config.lib.file.mkOutOfStoreSymlink "/home/${user}/.config/home-manager/users/${user}/xdg-config/nvim"; 
	};

	# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;

	programs.direnv.enable = true;

	programs.zellij = {
		enable = true;
	};

	# To find the desktop entries:
	# home.packages: `ls -l /etc/profiles/per-user/brianaung/share/applications/`
	# environment.systemPackages: `ls -l /run/current-system/sw/share/applications/`
	# xdg.mimeApps = {
	# 	enable = true;
	# 	defaultApplications = {
	# 		"text/html" = "brave-browser.desktop";
	# 		"x-scheme-handler/http" = "brave-browser.desktop";
	# 		"x-scheme-handler/https" = "brave-browser.desktop";
	# 		"x-scheme-handler/about" = "brave-browser.desktop";
	# 		"x-scheme-handler/unknown" = "brave-browser.desktop";

	# 		"x-scheme-handler/mailto" = "userapp-Thunderbird-995RI2.desktop";
	# 		"message/rfc822" = "userapp-Thunderbird-995RI2.desktop";
	# 		"x-scheme-handler/mid" = "userapp-Thunderbird-995RI2.desktop";
	# 	};

	# 	associations.added = {
	# 		"x-scheme-handler/mailto" = "userapp-Thunderbird-995RI2.desktop";
	# 		"x-scheme-handler/mid" = "userapp-Thunderbird-995RI2.desktop";
	# 	};
	# };
}
