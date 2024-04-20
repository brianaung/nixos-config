{ lib, pkgs, ... }:
with lib;
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

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet -t -r --asterisks -c dwl";
      };
    };
  };

  programs.sway = {
    enable = true;
    extraPackages = with pkgs; [
      wev # get keyboard, mouse pressed name
      mako # notification
      fuzzel # menu
      swaybg # wallpaper
      wl-clipboard # clipboard
      # screenshot
      grim
      slurp
    ];
  };

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    brightnessctl # backlight
    pavucontrol
    networkmanagerapplet

    (dwl.override {
      conf = ./config.h;
    })
    foot
  ];

  # ======================= dwl test ========================
  xdg.portal = {
    enable = mkDefault true;
    wlr.enable = mkDefault true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };

  services.dbus.enable = true;
  security.polkit.enable = true;
  programs.dconf.enable = true;
  programs.xwayland.enable = true;
  hardware.opengl.enable = true;

  # Enable scroll using modifier key.
  # services.xserver.libinput = {
  #   enable = true;
  #   mouse = {
  #     scrollButton = 3;
  #     scrollMethod = "button";
  #   };
  # };
}
