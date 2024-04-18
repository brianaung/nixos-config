{ pkgs, ... }:
{
  imports = [
    ./common.nix
    ./hardware/framework-13-7040-amd.nix
  ];

  services.kanata = {
    enable = true;
    keyboards.default.config = ''
      (defsrc
        grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
        tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
        caps a    s    d    f    g    h    j    k    l    ;    '    ret
        lsft z    x    c    v    b    n    m    ,    .    /    rsft
        lctl lmet lalt           spc            ralt rmet rctl)

      (deflayer qwerty
        grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
        tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
        @cap a    s    d    f    g    h    j    k    l    ;    '    ret
        lsft z    x    c    v    b    n    m    ,    .    /    rsft
        lctl lmet lalt           spc            ralt rmet rctl)

      (defalias
        cap (tap-hold-press 200 200 esc lctl))
    '';
  };

  services.xserver.displayManager = {
    defaultSession = "hyprland";
    sddm.enable = true;
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wev # get keyboard, mouse pressed name

    brightnessctl # backlight
    pavucontrol
    networkmanagerapplet

    waybar # statusbar
    swaynotificationcenter # notification
    fuzzel # menu
    swww # wallpaper

    wl-clipboard # clipboard

    # screenshot
    grim
    slurp
  ];

  environment.etc = {
    "xdg/gtk-3.0/settings.ini".text = ''
      [Settings]
      gtk-application-prefer-dark-theme=true
    '';
  };
}
