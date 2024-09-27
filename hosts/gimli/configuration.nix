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
      email = "brian@psdesignstudio.com";
      extraGroups = [ "docker" ];
      packages = with pkgs; [
        slack
        dbeaver-bin
        postman
        pandoc
        firefox
      ];
    };
    networking.iwd.enable = true;
    displayServer.wayland = {
      enable = true;
      session = "hyprland";
    };
  };

  environment.systemPackages = with pkgs; [
    vagrant
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
  '';
}
