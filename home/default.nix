{ pkgs, config, nix-colors, ... }:
let
  mkOutOfStoreSymlink = config.lib.file.mkOutOfStoreSymlink;
  configPath = "${config.xdg.configHome}/nixos-config/home";
in
{
  imports = [
    nix-colors.homeManagerModules.default
    ./sway.nix
    ./alacritty.nix
    ./zsh.nix
    ./starship.nix
    ./git.nix
    ./tmux-sessionizer.nix
  ];

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;

  colorScheme = nix-colors.colorSchemes.kanagawa;

  # These configs are managed outside of nix store.
  xdg.configFile = {
    nvim.source = mkOutOfStoreSymlink "${configPath}/nvim";
    tmux.source = mkOutOfStoreSymlink "${configPath}/tmux";
    sway.source = mkOutOfStoreSymlink "${configPath}/sway";
  };
}
