{ config, lib, darwin, ... }:
let
  mkOutOfStoreSymlink = config.lib.file.mkOutOfStoreSymlink;
  xdgHome = "${config.xdg.configHome}/nixos-config/home/brianaung";
in
{
  imports = [
    ./git.nix
    ./fzf.nix
    ./starship.nix
    ./git-wt.nix
    ./zoxide.nix
    ./fish.nix
  ] ++ lib.optionals (!darwin) [ ./mako.nix ]
  ++ lib.optionals darwin [ ./aerospace.nix ];

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;

  xdg.configFile = {
    nvim.source = mkOutOfStoreSymlink "${xdgHome}/nvim";
    tmux.source = mkOutOfStoreSymlink "${xdgHome}/tmux";
    ghostty.source = mkOutOfStoreSymlink "${xdgHome}/ghostty";
  } // lib.optionalAttrs (!darwin) {
    sway.source = mkOutOfStoreSymlink "${xdgHome}/sway";
    i3status-rust.source = mkOutOfStoreSymlink "${xdgHome}/i3status-rust";
  };
}
