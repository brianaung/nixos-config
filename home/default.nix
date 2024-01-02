{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    inputs.nix-colors.homeManagerModules.default

    ./modules/i3.nix
    ./modules/alacritty.nix
    ./modules/tmux.nix
    ./modules/neovim.nix
    ./modules/zsh.nix
    ./modules/starship.nix
    ./modules/git.nix
  ];

  # Most programs will use colors from here, except neovim, for consistency.
  # But it is quick to update neovim as well since I will be using base16 for both.
  colorScheme = inputs.nix-colors.colorSchemes.gruvbox-material-dark-hard;
  # colorScheme = inputs.nix-colors.colorSchemes.ayu-mirage;

  home.username = "brianaung";
  home.homeDirectory = "/home/brianaung";

  home.stateVersion = "23.05";

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "alacritty";
    BROWSER = "brave";
  };

  # Install Nix packages into your environment.
  home.packages = with pkgs; [
    brave
    dbeaver
    zathura
    flameshot

    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })

    fzf
    ripgrep
    fd
    eza
    xclip
    unzip
    gzip
    gnutar
    curl
    wget
    gnumake
    gcc
    ranger

    autorandr
    feh
    picom
		pavucontrol

		# testing
		# libnotify

		# I don't really need this tbh. I will only call them using i3 keybinds so.
		# dex
		# xss-lock
		# network-manager-applet
		# dmenu
		# i3status
  ];

  xdg.configFile = {
    "autorandr".source = ../xdg_config/autorandr;
    # ranger needs writable access to conf dir so cannot symlink the entire dir
    "ranger/rc.conf".source = ../xdg_config/ranger/rc.conf;
    "ranger/rifle.conf".source = ../xdg_config/ranger/rifle.conf;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
