{ pkgs, ... }:
{
  imports = [
    ../common.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "thorin"; # Define your hostname.

  modules = {
    users.brianaung = {
      enable = true;
      email = "brianaung16@gmail.com";
      extraGroups = [ "gamemode" ];
      packages = with pkgs; [
        obs-studio
        steam
        discord
        gamemode
      ];
    };
    networking.networkmanager.enable = true;
    displayServer.x11 = {
      enable = true;
    };
  };

  # virtualisation.docker.enable = true;
  # virtualisation.oci-containers.backend = "docker";
  # virtualisation.oci-containers.containers = {
  #   keycloak = {
  #     image = "keycloak/keycloak";
  #     cmd = [ "start-dev" ];
  #     environment = {
  #       KEYCLOAK_ADMIN = "admin";
  #       KEYCLOAK_ADMIN_PASSWORD= "admin";
  #     };
  #     ports = [ "127.0.0.1:8080:8080" ];
  #   };
  # };
}
