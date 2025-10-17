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
    ./tmux-sessionizer.nix
    ./git-wt.nix
  ];

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;

  xdg.configFile = {
    nvim.source = mkOutOfStoreSymlink "${xdgHome}/nvim";
    tmux.source = mkOutOfStoreSymlink "${xdgHome}/tmux";
  };
}
