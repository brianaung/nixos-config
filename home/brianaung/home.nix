{ config, ... }:
let
  mkOutOfStoreSymlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  imports = [
    ./programs/hyprland.nix
    ./programs/zsh.nix
    ./programs/starship.nix
    ./programs/git.nix
    ./programs/fzf.nix
    ./programs/tmux.nix
    ./programs/alacritty.nix
    ./programs/kitty.nix
    ./programs/yazi.nix
    ./programs/waybar.nix
    ./programs/swaync.nix
    ./programs/fuzzel.nix
    ./programs/qutebrowser.nix

    ./scripts/tmux-sessionizer.nix
    ./scripts/hyprmonitor.nix
    ./scripts/umpv.nix

    ./misc/gtk.nix
  ];

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;

  xdg.configFile.nvim.source = mkOutOfStoreSymlink "${config.xdg.configHome}/nixos-config/home/brianaung/nvim";
}
