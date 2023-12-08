{ config, pkgs, ... }:

{
  home.username = "brianaung";
  home.homeDirectory = "/home/brianaung"; # path to manage

  home.stateVersion = "23.05";

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
    pkgs.zathura
    # using with i3
    pkgs.feh
    pkgs.autorandr
    pkgs.picom
    # lang
    pkgs.rustup
    pkgs.go
    pkgs.opam
  ];

  # Manage dotfiles that lives in ~/
  home.file = {
    ".gitconfig".source = ./dotfiles/git/.gitconfig;
    ".zshrc".source = ./dotfiles/zsh/.zshrc;
    # Link to scripts
    ".local/bin/tmux-sessionizer".source = ./dotfiles/bin/tmux-sessionizer;
  };

  # Manage dotfiles in XDG config directory
  xdg.configFile = {
    "i3".source = ./dotfiles/i3;
    "i3status".source = ./dotfiles/i3status;
    "alacritty".source = ./dotfiles/alacritty;
    "nvim".source = ./dotfiles/nvim;
    "tmux".source = ./dotfiles/tmux;
    "autorandr".source = ./dotfiles/autorandr;
    "starship.toml".source = ./dotfiles/starship/starship.toml;
    # ranger needs writable access to conf dir so cannot symlink the entire dir
    "ranger/rc.conf".source = ./dotfiles/ranger/rc.conf;
    "ranger/rifle.conf".source = ./dotfiles/ranger/rifle.conf;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
