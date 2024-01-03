{ pkgs, ... }:

{
  imports =
    [ # import the main configuration.
      /etc/nixos/configuration.nix
    ];

	# enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # configure X11
  services.xserver = {
    enable = true;
    desktopManager.xterm.enable = false;
    displayManager.defaultSession = "none+i3";
    windowManager.i3.enable = true;
  };

	# enable git
  programs.git.enable = true;

	# set default shell
  programs.zsh.enable = true;
  users.users.brianaung.shell = pkgs.zsh;

	# i need this to be able to run non-nix executables
  programs.nix-ld.enable = true;

 	services.udisks2.enable = true;
}
