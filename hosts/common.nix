{ pkgs, lib, user, ... }:
{
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  system.stateVersion = "23.11";

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Kernel and firmware
  boot.kernelPackages = pkgs.linuxPackages_latest;
  services.fwupd.enable = true;

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Timezone and locale
  time.timeZone = "Australia/Melbourne";
  i18n.defaultLocale = "en_AU.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  # Use zram (instead of physical swap).
  zramSwap.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable bluetooth support.
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  programs.fish.enable = true;
  users.users.${user} = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      vivaldi
      zathura
      obsidian
      pandoc
      obs-studio
    ];
  };

  # Cosmic
  services.desktopManager.cosmic.enable = true;
  # cosmic-greeter (greetd) having "unable to start greetd" issues
  # services.displayManager.cosmic-greeter.enable = true;
  services.displayManager.gdm.enable = true;

  networking.networkmanager.enable = true;

  # services.kanata = {
  #   enable = true;
  #   keyboards.default = {
  #     config = ''
  #     (defsrc
  #       grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
  #       tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
  #       caps a    s    d    f    g    h    j    k    l    ;    '    ret
  #       lsft z    x    c    v    b    n    m    ,    .    /    rsft
  #       lctl lmet lalt           spc            ralt rctl)

  #     (deflayer qwerty
  #       grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
  #       tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
  #       @cap a    s    d    f    g    h    j    k    l    ;    '    ret
  #       lsft z    x    c    v    b    n    m    ,    .    /    rsft
  #       lctl lmet lalt           spc            ralt rctl)

  #     (defalias
  #       cap (multi f24 (tap-hold-press 200 200 esc lctl)))
  #     '';
  #     devices = [
  #       "/dev/input/by-path/platform-i8042-serio-0-event-kbd"
  #     ];
  #   };
  # };

  # Set session variables.
  environment.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "foot";
    QT_SCALE_FACTOR_ROUNDING_POLICY = "RoundPreferFloor";
    NIXOS_OZONE_WL = 1;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    ripgrep
    fd
    bat
    jq
    btop
    tmux
    imv
    mpv
    syncthing
    devenv
    claude-code
    gh
    bitbucket-cli
  ];

  # To load/unload configured shells based on current directory.
  programs.direnv.enable = true;

  # Install fonts.
  fonts.packages = with pkgs; [
    apple-fonts
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.nerd-fonts.iosevka
  ];

  programs.nix-ld.enable = true;
}
