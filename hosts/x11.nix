{ pkgs, ... }:
{
  services.xserver.windowManager.awesome = with pkgs; {
    enable = true;
  };

  services.xserver.displayManager = {
    lightdm.enable = true;
    sessionCommands = ''
      ${pkgs.xorg.xrdb}/bin/xrdb -merge <${pkgs.writeText "Xresources" ''
        *dpi: 125
        Xft.dpi: 125
      ''}
    '';
  };

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

  environment.systemPackages = with pkgs; [
    feh
    autorandr
    flameshot
    xclip
    brightnessctl
  ];

  programs.nm-applet.enable = true;
}
