{ pkgs, user, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../common.nix
  ];

  networking.hostName = "thorin"; # Define your hostname.

  users.users.${user} = {
    packages = with pkgs; [
      slack
      dbeaver-bin
      postman
    ];
  };

  environment.sessionVariables = {
    ESLINT_USE_FLAT_CONFIG = "true";
  };
}
