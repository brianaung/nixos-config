{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../common.nix
  ];

  networking.hostName = "gimli"; # Define your hostname.

  modules = {
    users.brianaung = {
      enable = true;
      email = "brianaung16@gmail.com";
      extraGroups = [ "docker" ];
      packages = with pkgs; [
        slack
        dbeaver-bin
        postman
        pandoc
        firefox
        thunderbird
      ];
    };
    networking.networkmanager.enable = true;
    displayServer.x11 = {
      enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    (vagrant.override { withLibvirt = false; })
  ];

  environment.sessionVariables = {
    ESLINT_USE_FLAT_CONFIG = "true";
  };

  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.package = pkgs.unstable.virtualbox;

  virtualisation.docker.enable = true;

  networking.extraHosts = ''
    192.168.56.56  cms.simonds.test
    192.168.56.56  content.simonds.test
    192.168.56.56  product.simonds.test
    192.168.56.56  trunk.test
  '';
}
