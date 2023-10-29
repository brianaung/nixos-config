{ config, pkgs, ... }:

{
  home.username = "brianaung";
  home.homeDirectory = "/home/brianaung"; # path to manage

  home.stateVersion = "23.05";

  # Install Nix packages into your environment.
  home.packages = [
    pkgs.neovim
    pkgs.tmux
    pkgs.zsh
    pkgs.starship
    pkgs.git
    pkgs.eza
    pkgs.ripgrep
    pkgs.fzf
    pkgs.slides
    # language specific
    pkgs.rustup
  ];

  # Manage dotfiles that lives in ~/
  home.file = {
    ".gitconfig".source = ./dotfiles/git/.gitconfig;
    ".zshrc".source = ./dotfiles/zsh/.zshrc;
    ".tmux.conf".source = ./dotfiles/tmux/.tmux.conf;
    # Link to scripts
    ".local/bin/tmux-sessionizer".source = ./dotfiles/bin/tmux-sessionizer;
  };

  # Manage dotfiles in XDG config directory
  xdg.configFile = {
    "nvim".source = ./dotfiles/nvim;
    "starship.toml".source = ./dotfiles/starship/starship.toml;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
