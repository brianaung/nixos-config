{ pkgs, user, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../common.nix
  ];

  networking.hostName = "thorin";

  users.users.${user} = {
    packages = with pkgs; [
      dbeaver-bin
      slack

      claude-code
      gh
      bitbucket-cli
      devenv
      terraform
      awscli2
      ssm-session-manager-plugin
      terraform-ls
      docker-compose
      pulumi
    ];
  };

  environment.sessionVariables = {
    ESLINT_USE_FLAT_CONFIG = "true";
  };

  networking.extraHosts = ''
    13.55.136.84 simonds-cms
    54.66.87.15 simonds-product
    3.24.159.248 simonds-staging
    127.0.0.1 mysimonds.simonds.test
    127.0.0.1 gallery.simonds.test
    127.0.0.1 local.simonds.test
    127.0.0.1 product.simonds.test
  '';
}
