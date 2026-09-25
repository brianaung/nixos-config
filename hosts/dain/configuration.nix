{ pkgs, user, ... }:
{
  imports = [ ../common.nix ];

  networking.hostName = "dain";
  networking.computerName = "dain";

  users.knownUsers = [ user ];
  users.users.${user} = {
    uid = 501; # `id -u brianaung`
    home = "/Users/${user}";
    shell = pkgs.fish;
  };

  system.primaryUser = user;

  nix.settings.trusted-users = [ "@admin" user ];

  environment.systemPackages = with pkgs; [
    mos
    ghostty-bin
  ];

  security.pam.services.sudo_local.touchIdAuth = true;

  system.defaults = {
    # dock.autohide = true;
    # finder.AppleShowAllExtensions = true;
    # NSGlobalDomain.AppleShowAllExtensions = true;
  };

  system.stateVersion = 7;
}
