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
    awesome.source = mkOutOfStoreSymlink "${xdgHome}/awesome";
    wezterm.source = mkOutOfStoreSymlink "${xdgHome}/wezterm";
    nvim.source = mkOutOfStoreSymlink "${xdgHome}/nvim";
  };
}
