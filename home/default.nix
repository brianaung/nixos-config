{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.nix-colors.homeManagerModules.default

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

  home.username = "brianaung";
  home.homeDirectory = "/home/brianaung";

  home.stateVersion = "23.05";

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  # Install Nix packages into your environment.
  home.packages = [
    pkgs.alacritty
    pkgs.neovim
    pkgs.tmux
    pkgs.zsh
    pkgs.starship
    pkgs.git
    pkgs.eza
    pkgs.ripgrep
    pkgs.fzf
    pkgs.xclip
    pkgs.slides
    pkgs.ranger
    pkgs.websocat
    # using with i3
    pkgs.feh
    pkgs.autorandr
    pkgs.picom
    pkgs.flameshot
    pkgs.zathura
    # lang
    pkgs.rustup
    pkgs.go
    pkgs.opam
    # misc
    pkgs.dbeaver
    pkgs.brave
  ];

  # Manage dotfiles that lives in ~/
  home.file = {
    # Link to scripts
    ".local/bin/tmux-sessionizer".source = ./xdg_config/bin/tmux-sessionizer;
  };

  # Manage dotfiles in XDG config directory
  xdg.configFile = {
    "i3".source = ./xdg_config/i3;
    "i3status".source = ./xdg_config/i3status;
    "nvim".source = ./xdg_config/nvim;
    "autorandr".source = ./xdg_config/autorandr;
    # ranger needs writable access to conf dir so cannot symlink the entire dir
    "ranger/rc.conf".source = ./xdg_config/ranger/rc.conf;
    "ranger/rifle.conf".source = ./xdg_config/ranger/rifle.conf;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "alacritty";
    BROWSER = "brave";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
