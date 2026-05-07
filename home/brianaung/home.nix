{ config, ... }:
let
  mkOutOfStoreSymlink = config.lib.file.mkOutOfStoreSymlink;
  xdgHome = "${config.xdg.configHome}/nixos-config/home/brianaung";
in
{
  imports = [
    ./git.nix
    ./fzf.nix
    ./mako.nix
    ./starship.nix
    ./git-wt.nix
  ];

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;

  xdg.configFile = {
    sway.source = mkOutOfStoreSymlink "${xdgHome}/sway";
    nvim.source = mkOutOfStoreSymlink "${xdgHome}/nvim";
    tmux.source = mkOutOfStoreSymlink "${xdgHome}/tmux";
    ghostty.source = mkOutOfStoreSymlink "${xdgHome}/ghostty";
    i3status-rust.source = mkOutOfStoreSymlink "${xdgHome}/i3status-rust";
  };
}
