{ pkgs, currentUser, ... }:
{
  imports = [
    ./common.nix
    ./hardware/lenovo-ideapad-slim-5.nix
  ];

  services.xserver.xkb = {
    layout = "au";
    variant = "";
  };

  # Enable scroll using modifier key.
  services.libinput = {
    enable = true;
    mouse = {
      scrollButton = 3;
      scrollMethod = "button";
    };
  };

  services.displayManager.defaultSession = "none+i3";
  services.xserver.displayManager = {
    lightdm.enable = true;
    sessionCommands = ''
      setxkbmap -option 'ctrl:nocaps'
      xcape -e 'Control_L=Escape'
    '';
  };

  # fractional scaling (needs to be in sessionCommands)
  # ${pkgs.xorg.xrdb}/bin/xrdb -merge <${pkgs.writeText "Xresources" ''
  #   *dpi: 120
  #   Xft.dpi: 120
  # ''}

  services.xserver.windowManager.i3.enable = true;

  users.users.${currentUser} = {
    packages = with pkgs; [ postman ];
  };

  environment.systemPackages = with pkgs; [
    vagrant

    xcape
    xclip
    feh
    autorandr
    flameshot
  ];

  programs.nm-applet.enable = true;

  # Set gtk settings.
  environment.etc = {
    "xdg/gtk-3.0/settings.ini".text = ''
      [Settings]
      gtk-application-prefer-dark-theme=true
    '';
  };

  # Enable virtualbox.
  virtualisation.virtualbox.host.enable = true;

  networking.extraHosts = ''
    192.168.56.56  cms.simonds.test
    192.168.56.56  content.simonds.test
  '';

  services.fprintd.enable = true;
  services.fprintd.tod.enable = true;
  services.fprintd.tod.driver = pkgs.libfprint-2-tod1-vfs0090; 
}
