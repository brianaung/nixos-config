{ config, ... }:
let
  mkOutOfStoreSymlink = config.lib.file.mkOutOfStoreSymlink;
  xdgHome = "${config.xdg.configHome}/nixos-config/home/brianaung";
in
{
  imports = [
    ./fish.nix
    ./git.nix
    ./fzf.nix
    ./git-wt.nix
  ];

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;

  xdg.configFile = {
    sway.source = mkOutOfStoreSymlink "${xdgHome}/sway";
    nvim.source = mkOutOfStoreSymlink "${xdgHome}/nvim";
    wezterm.source = mkOutOfStoreSymlink "${xdgHome}/wezterm";
  };
}
