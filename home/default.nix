{ config, nix-colors, ... }:
let
  mkOutOfStoreSymlink = config.lib.file.mkOutOfStoreSymlink;
  configPath = "${config.xdg.configHome}/nixos-config/home";
in
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

  xdg.configFile = {
    nvim.source = mkOutOfStoreSymlink "${configPath}/nvim";
    tmux.source = mkOutOfStoreSymlink "${configPath}/tmux";
    hypr.source = mkOutOfStoreSymlink "${configPath}/hypr";
    waybar.source = mkOutOfStoreSymlink "${configPath}/waybar";
  };
}
