{ config, lib, pkgs, ... }:
let
  cfg = config.modules.users;
in
{
  options.modules.users = {
    brianaung = {
      enable = lib.mkEnableOption "enable user 'brianaung'";
      email = lib.mkOption {
        type = lib.types.str;
        default = "brianaung16@gmail.com";
      };
      extraGroups = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ ];
      };
      packages = lib.mkOption {
        type = lib.types.listOf lib.types.package;
        default = [ ];
      };
    };
  };

  config = lib.mkMerge [
    (lib.mkIf (cfg.brianaung.enable) {
      # Define a user account. Don't forget to set a password with ‘passwd’.
      users.users.brianaung = {
        isNormalUser = true;
        shell = pkgs.zsh;
        extraGroups = lib.lists.unique [
          "wheel"
        ] ++ cfg.brianaung.extraGroups;
        packages = with pkgs; [
          firefox
          brave
          zathura
          obsidian
        ] ++ cfg.brianaung.packages;
      };
      programs.zsh.enable = true;

      home-manager.users.brianaung = { pkgs, ... }: {
        programs.git.userName = "brianaung";
        programs.git.userEmail = lib.mkDefault cfg.brianaung.email;
      };
    })
  ];
}
