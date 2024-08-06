{ config, ... }:
let
  mkOutOfStoreSymlink = config.lib.file.mkOutOfStoreSymlink;
  configPath = "${config.xdg.configHome}/nixos-config/home";
in
{
  imports = [
    # ./wayland.nix
    # ./kanshi.nix

    # x11

    ./alacritty.nix
    ./zsh.nix
    ./starship.nix
    ./git.nix
    ./fzf.nix

    ./tmux-sessionizer.nix

    ../modules/colors.nix
  ];

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;

  xdg.configFile = {
    awesome.source = mkOutOfStoreSymlink "${configPath}/awesome";
    nvim.source = mkOutOfStoreSymlink "${configPath}/nvim";
    tmux.source = mkOutOfStoreSymlink "${configPath}/tmux";
    "river/init" = {
      text = builtins.readFile ./river/init;
      executable = true;
    };
  };
}
