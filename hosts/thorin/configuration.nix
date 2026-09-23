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

      opencode
      pi-coding-agent

      gh
      bitbucket-cli
      devenv
      terraform
      awscli2
      ssm-session-manager-plugin
      terraform-ls
      docker-compose
      pulumi

      xprintidle # for kairos
    ];
  };

  environment.sessionVariables = {
    ESLINT_USE_FLAT_CONFIG = "true";
  };

  programs.steam.enable = true;

  networking.extraHosts = ''
    13.55.136.84 simonds-cms
    54.66.87.15 simonds-product
    3.24.159.248 simonds-staging
    54.66.52.130 choice-metrics
  '';
}
