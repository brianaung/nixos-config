{ config, nix-colors, ... }:
{
  imports = [
    nix-colors.homeManagerModules.default
    ./i3.nix
    ./alacritty.nix
    ./zsh.nix
    ./starship.nix
    ./git.nix
    ./tmux-sessionizer.nix
  ];

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;

  colorScheme = nix-colors.colorSchemes.kanagawa;

  # I want to manage these configs outside of nix store.
  xdg.configFile.nvim.source = config.lib.file.mkOutOfStoreSymlink "${config.xdg.configHome}/nixos-config/home/nvim";
  xdg.configFile.tmux.source = config.lib.file.mkOutOfStoreSymlink "${config.xdg.configHome}/nixos-config/home/tmux";
}
