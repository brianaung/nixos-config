{ config, ... }:
let
  mkOutOfStoreSymlink = config.lib.file.mkOutOfStoreSymlink;
in
{
  imports = [
    ./programs/hyprland.nix
    ./programs/waybar.nix
    ./programs/fuzzel.nix
    ./programs/foot.nix

    ./programs/awesome/theme.nix

    ./programs/fish.nix
    ./programs/git.nix
    ./programs/fzf.nix
    ./programs/tmux.nix
    ./programs/yazi/yazi.nix
    ./programs/qutebrowser.nix

    ./services/kanshi.nix

    ./scripts/tmux-sessionizer.nix
    ./scripts/hyprmonitor.nix
    ./scripts/umpv.nix

    ./misc/gtk.nix
  ];

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;

  xdg.configFile.nvim.source = mkOutOfStoreSymlink "${config.xdg.configHome}/nixos-config/home/brianaung/programs/nvim";
  xdg.configFile."awesome/rc.lua".source = mkOutOfStoreSymlink "${config.xdg.configHome}/nixos-config/home/brianaung/programs/awesome/rc.lua";
}
