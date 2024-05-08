{
  lib,
  pkgs,
  currentUser,
  currentHost,
  ...
}:
with lib; {
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  system.stateVersion = "23.11";

  # Set your time zone.
  time.timeZone = "Australia/Melbourne";

  # Select internationalisation properties.
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

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Update kernel to latest.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.consoleLogLevel = 3;

  # To update firmware.
  # services.fwupd.enable = true;

  # Use zram (instead of physical swap).
  zramSwap.enable = true;

  # Enable networking.
  networking.hostName = currentHost; # Define your hostname.
  networking.networkmanager.enable = true; # Enable networking

  # Enable sound with pipewire.
  sound.enable = true;
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
  # services.blueman.enable = true;

  powerManagement.powertop.enable = mkForce true;

  # Setup gui, mouse, keyboard, etc.
  # Using wayland on thorin (testing), x11 on gimli (stable)
  services.xserver.enable = true;
  services.xserver.desktopManager = {
    xterm.enable = false;
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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${currentUser} = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    packages = with pkgs; [
      thunderbird
      firefox
      zathura
      obsidian
      obs-studio
      gimp
      smplayer # mpv backend
      strawberry
    ];
  };
  programs.zsh.enable = true;

  # Set session variables.
  environment.sessionVariables = rec {
    TERMINAL = "alacritty";
    NIXOS_OZONE_WL = "1";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    ripgrep
    fd
    fzf
    xfce.thunar
    btop
    neovim
    tmux
    imv
  ];

  # Install fonts.
  fonts.packages = with pkgs; [
    (nerdfonts.override {
      fonts = [
        "JetBrainsMono"
        "Terminus"
      ];
    })
  ];

  # To load/unload configured shells based on current directory.
  programs.direnv.enable = true;

  # Enable docker.
  # virtualisation.docker.enable = true;

  # Enable virtualbox.
  # virtualisation.virtualbox.host.enable = true;

  # Enable flakes.
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
