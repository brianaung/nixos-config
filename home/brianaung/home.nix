{ config, ... }:
let
  mkOutOfStoreSymlink = config.lib.file.mkOutOfStoreSymlink;
  configPath = "${config.xdg.configHome}/nixos-config/home/brianaung";
in
{
  imports = [
    ./programs/zsh.nix
    ./programs/starship.nix
    ./programs/git.nix
    ./programs/fzf.nix
    ./programs/tmux.nix
    ./programs/alacritty.nix
    ./programs/waybar.nix
    ./programs/swaync.nix
    ./programs/fuzzel.nix
    ./scripts/tmux-sessionizer.nix
    ./misc/gtk.nix
  ];

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;

  xdg.configFile = {
    nvim.source = mkOutOfStoreSymlink "${configPath}/nvim";
    hypr.source = mkOutOfStoreSymlink "${configPath}/hypr";
  };
}
