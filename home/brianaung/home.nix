{ config, ... }:
let
  mkOutOfStoreSymlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  imports = [
    ./fish.nix
    ./git.nix
    ./fzf.nix
    ./tmux.nix
    ./tmux-sessionizer.nix
  ];

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;

  xdg.configFile.nvim.source = mkOutOfStoreSymlink "${config.xdg.configHome}/nixos-config/home/brianaung/nvim";
  xdg.configFile.sway.source = mkOutOfStoreSymlink "${config.xdg.configHome}/nixos-config/home/brianaung/sway";
}
