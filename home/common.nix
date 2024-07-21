{ config
, inputs
, ...
}:
let
  mkOutOfStoreSymlink = config.lib.file.mkOutOfStoreSymlink;
  configPath = "${config.xdg.configHome}/nixos-config/home";
in
{
  imports = [
    inputs.nix-colors.homeManagerModules.default
    ./wayland.nix
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

  colorScheme = {
    palette = {
      base00 = "#1F1F28";
      base01 = "#2A2A37";
      base02 = "#223249";
      base03 = "#727169";
      base04 = "#C8C093";
      base05 = "#DCD7BA";
      base06 = "#938AA9";
      base07 = "#363646";
      base08 = "#C34043";
      base09 = "#FFA066";
      base0A = "#DCA561";
      base0B = "#98BB6C";
      base0C = "#7FB4CA";
      base0D = "#7E9CD8";
      base0E = "#957FB8";
      base0F = "#D27E99";
    };
  };

  # These configs are managed outside of nix store.
  xdg.configFile = {
    nvim.source = mkOutOfStoreSymlink "${configPath}/nvim";
    nvimColors = {
      target = "${configPath}/nvim/lua/modules/colors.lua";
      text = ''
        local M = {}
        M.Black = "#${config.colors.Black}"
        M.BrightBlack = "#${config.colors.BrightBlack}"
        M.Red = "#${config.colors.Red}"
        M.BrightRed = "#${config.colors.BrightRed}"
        M.Green = "#${config.colors.Green}"
        M.BrightGreen = "#${config.colors.BrightGreen}"
        M.Yellow = "#${config.colors.Yellow}"
        M.BrightYellow = "#${config.colors.BrightYellow}"
        M.Blue = "#${config.colors.Blue}"
        M.BrightBlue = "#${config.colors.BrightBlue}"
        M.Magenta = "#${config.colors.Magenta}"
        M.BrightMagenta = "#${config.colors.BrightMagenta}"
        M.Cyan = "#${config.colors.Cyan}"
        M.BrightCyan = "#${config.colors.BrightCyan}"
        M.White = "#${config.colors.White}"
        M.BrightWhite = "#${config.colors.BrightWhite}"
        return M
      '';
    };
    tmux.source = mkOutOfStoreSymlink "${configPath}/tmux";
  };
}
