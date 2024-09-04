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
      packages = with pkgs; [
        slack
        dbeaver-bin
        postman
      ];
    };
    displayServer.x11.enable = true;
  };

  environment.systemPackages = with pkgs; [
    vagrant
  ];

  environment.sessionVariables = {
    ESLINT_USE_FLAT_CONFIG = "true";
  };

  # Enable virtualbox.
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.package = pkgs.unstable.virtualbox;

  networking.extraHosts = ''
    192.168.56.56  cms.simonds.test
    192.168.56.56  content.simonds.test
    192.168.56.56  product.simonds.test
  '';
}
