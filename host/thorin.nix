{ pkgs, lib, ... }:
with lib; {
  imports = [
    ./common.nix
    ./hardware/framework-13-7040-amd.nix
  ];

  powerManagement.powertop.enable = mkForce true;

  # Set session variables.
  environment.sessionVariables = rec {
    NIXOS_OZONE_WL = "1";
  };

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
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet -t -r --asterisks -c sway";
      };
    };
    vt = 7;
  };

  programs.sway = {
    enable = true;
    extraPackages = with pkgs; [
      wev # get keyboard, mouse pressed name
      brightnessctl
      pavucontrol
      networkmanagerapplet
      mako # notification
      wl-clipboard # clipboard
      # screenshot
      grim
      slurp
      # screenlock
      swayidle
      swaylock
    ];
  };
}
