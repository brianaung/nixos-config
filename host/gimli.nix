{ pkgs, currentUser, ... }:
{
  imports = [
    ./common.nix
    ./hardware/lenovo-ideapad-slim-5.nix
  ];

  users.users.${currentUser} = {
    packages = with pkgs; [ slack ];
  };

  environment.systemPackages = with pkgs; [
    vagrant
  ];

  # Enable virtualbox.
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.package = pkgs.unstable.virtualbox;

  networking.extraHosts = ''
    192.168.56.56  cms.simonds.test
    192.168.56.56  content.simonds.test
  '';
}
