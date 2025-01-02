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
  hardware.bluetooth.powerOnBoot = false;

  programs.fish.enable = true;
  users.users.${user} = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      librewolf
      zathura
      obsidian
      pandoc
      thunderbird
      strawberry
    ];
  };

  # Desktop environment
  services.xserver = {
    enable = true;
    desktopManager = {
      xterm.enable = false;
      gnome.enable = true;
    };
    displayManager.gdm.enable = true;
  };
  programs.dconf = {
    enable = true;
    profiles.user.databases = [
      {
        settings = {
          "org/gnome/desktop/wm/keybindings" = {
            switch-to-workspace-1 = [ "<Super>1" ];
            switch-to-workspace-2 = [ "<Super>2" ];
            switch-to-workspace-3 = [ "<Super>3" ];
            switch-to-workspace-4 = [ "<Super>4" ];
            move-to-workspace-1 = [ "<Super><Shift>1" ];
            move-to-workspace-2 = [ "<Super><Shift>2" ];
            move-to-workspace-3 = [ "<Super><Shift>3" ];
            move-to-workspace-4 = [ "<Super><Shift>4" ];
            close = [ "<Super>q" ];
            minimize = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
            toggle-maximized = [ "<Super>m" ];
            toggle-fullscreen = [ "<Super>f" ];
          };
          "org/gnome/shell/keybindings" = {
            switch-to-application-1 = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
            switch-to-application-2 = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
            switch-to-application-3 = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
            switch-to-application-4 = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
            toggle-message-tray = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
          };
          "org/gnome/shell/app-switcher" = {
            current-workspace-only = true;
          };
          "org/gnome/desktop/interface" = {
            color-scheme = "prefer-dark";
            show-battery-percentage = true;
          };
          "org/gnome/desktop/peripherals/mouse" = {
            accel-profile = "flat";
          };
          "org/gnome/mutter" = {
            experimental-features = [ "scale-monitor-framebuffer" ];
          };
          "org/gnome/mutter/keybindings" = {
            toggle-tiled-left = [ "<Super>h" ];
            toggle-tiled-right = [ "<Super>l" ];
            switch-monitor = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
          };
          "org/gnome/settings-daemon/plugins/power" = {
            ambient-enabled = false;
          };
          "org/gnome/settings-daemon/plugins/media-keys" = {
            screensaver = [ "<Super>e" ];
            logout = [ "<Super><Shift>e" ];
          };
          "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
            name = "Launch terminal";
            command = "ghostty";
            binding = "<Super><Shift>Return";
          };
        };
      }
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
        lctl lmet lalt           spc            ralt rctl)

      (deflayer qwerty
        grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
        tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
        @cap a    s    d    f    g    h    j    k    l    ;    '    ret
        lsft z    x    c    v    b    n    m    ,    .    /    rsft
        lctl lalt lmet           spc            rmet rctl)

      (defalias
        cap (multi f24 (tap-hold-press 200 200 esc lctl)))
    '';
  };

  # Set session variables.
  environment.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "foot";
    QT_SCALE_FACTOR_ROUNDING_POLICY = "RoundPreferFloor";
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
    wl-clipboard
  ];

  # To load/unload configured shells based on current directory.
  programs.direnv.enable = true;

  # Install fonts.
  fonts.packages = with pkgs; [
    apple-fonts
    (nerdfonts.override {
      fonts = [
        "JetBrainsMono"
        "Terminus"
        "Iosevka"
      ];
    })
  ];
}
