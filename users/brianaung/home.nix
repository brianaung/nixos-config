{ config, pkgs, lib, inputs, user, ... }:

{
	imports = [
		inputs.nix-colors.homeManagerModules.default
		./programs/zsh.nix
		./programs/git.nix
		./programs/i3.nix
		./programs/alacritty.nix
		./programs/starship.nix
		./scripts/tmux-sessionizer.nix
	];

	colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-hard;

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
		obsidian
		zathura
		thunderbird
		brave
		firefox
		spotify
		slack
		postman

		(nerdfonts.override { fonts = [ "JetBrainsMono" "Terminus" "UbuntuMono"]; })

		neovim
		tmux
		flameshot
		vagrant

		fzf
		ripgrep
		fd
		eza
		xclip
		unzip
		lsof
		cloc

		# Usually I use either flakes or docker for dev environment, but I want them globally installed atm
		gnumake
		gcc
		elixir_1_16
		rustc
		cargo
		php83
		php83Packages.composer
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
		"nvim".source = config.lib.file.mkOutOfStoreSymlink "/home/${user}/.config/home-manager/users/${user}/xdg-config/nvim";
		"tmux".source = config.lib.file.mkOutOfStoreSymlink "/home/${user}/.config/home-manager/users/${user}/xdg-config/tmux";
	};

	# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;

	programs.direnv.enable = true;

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
