{ pkgs, currentUser, ... }:
{
  imports = [
    ./common.nix
    ./hardware/lenovo-ideapad-slim-5.nix
  ];

  networking.extraHosts = ''
    192.168.56.56  cms.simonds.test
    192.168.56.56  content.simonds.test
  '';

  users.users.${currentUser} = {
    packages = with pkgs; [ postman ];
  };

  environment.systemPackages = with pkgs; [ vagrant ];

  services.xserver.displayManager = {
    sessionCommands = ''
      ${pkgs.xorg.xrdb}/bin/xrdb -merge <${pkgs.writeText "Xresources" ''
        *dpi: 120
        Xft.dpi: 120
      ''}
    '';
  };
}
