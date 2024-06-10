{ config
, nix-colors
, ...
}:
let
  mkOutOfStoreSymlink = config.lib.file.mkOutOfStoreSymlink;
  configPath = "${config.xdg.configHome}/nixos-config/home";
in
{
  imports = [
    nix-colors.homeManagerModules.default
    ./wayland.nix
    ./alacritty.nix
    ./zsh.nix
    ./starship.nix
    ./git.nix
    ./tmux-sessionizer.nix
  ];

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;

  colorScheme = {
    palette = {
      base00 = "181616";
      base01 = "282727";
      base02 = "223249";
      base03 = "727169";
      base04 = "C8C093";
      base05 = "DCD7BA";
      base06 = "938AA9";
      base07 = "393836";
      base08 = "C34043";
      base09 = "FFA066";
      base0A = "DCA561";
      base0B = "98BB6C";
      base0C = "7FB4CA";
      base0D = "7E9CD8";
      base0E = "957FB8";
      base0F = "D27E99";
    };
  };

  # These configs are managed outside of nix store.
  xdg.configFile = {
    nvim.source = mkOutOfStoreSymlink "${configPath}/nvim";
    tmux.source = mkOutOfStoreSymlink "${configPath}/tmux";
  };
}
