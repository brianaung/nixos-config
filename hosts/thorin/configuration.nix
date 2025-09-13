{ pkgs, user, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../common.nix
  ];

  networking.hostName = "thorin"; # Define your hostname.

  users.users.${user} = {
    extraGroups = [ "docker" ];
    packages = with pkgs; [
      unstable.devenv
      localstack
      unstable.terraform
      unstable.awscli2
      terraform-local
      unstable.claude-code
      gh
      bitbucket-cli
      docker-compose
      slack
      dbeaver-bin
      postman
    ];
  };

  virtualisation.docker.enable = true;

  environment.sessionVariables = {
    ESLINT_USE_FLAT_CONFIG = "true";
  };

  networking.extraHosts = ''
    13.55.136.84 simonds-cms
    54.66.87.15 simonds-product
    127.0.0.1 mysimonds.simonds.test
    127.0.0.1 gallery.simonds.test
    127.0.0.1 local.simonds.test
    127.0.0.1 product.simonds.test
  '';
}
