{ pkgs, user, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../common.nix
  ];

  networking.hostName = "gimli"; # Define your hostname.

  users.users.${user} = {
    extraGroups = [ "docker" ];
    packages = with pkgs; [
      slack
      dbeaver-bin
      postman
    ];
  };

  environment.systemPackages = with pkgs; [
    (vagrant.override { withLibvirt = false; })
  ];

  environment.sessionVariables = {
    ESLINT_USE_FLAT_CONFIG = "true";
  };

  virtualisation.virtualbox.host.enable = true;

  virtualisation.docker.enable = true;

  networking.extraHosts = ''
    192.168.56.56  cms.simonds.test
    192.168.56.56  content.simonds.test
    192.168.56.56  product.simonds.test
    192.168.56.56  trunk.test
  '';
}
