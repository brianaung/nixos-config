{ pkgs, ... }:

{
	virtualisation.virtualbox.host.enable = true;

	users.mutableUsers = false;

	# enable flakes
	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	# allow unfree packages
	nixpkgs.config.allowUnfree = true;

	# temporary fix for obsidian issue: https://github.com/junegunn/fzf/issues/337
	nixpkgs.config.permittedInsecurePackages = [ "electron-25.9.0" ];

	networking.hostName = "nixos"; # Define your hostname.
	# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

	# Configure network proxy if necessary
	# networking.proxy.default = "http://user:password@proxy:port/";
	# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

	# Enable networking
	networking.networkmanager.enable = true;

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

	environment.systemPackages = with pkgs; [
		feh
		picom
		arandr
		autorandr
		pulseaudio
		pavucontrol
		brightnessctl

		# dex
		# xss-lock
		# network-manager-applet
		# dmenu
		# i3status
	];

	# Some programs need SUID wrappers, can be configured further or are
	# started in user sessions.
	# programs.mtr.enable = true;
	# programs.gnupg.agent = {
	#   enable = true;
	#   enableSSHSupport = true;
	# };

	# i need this to be able to run non-nix executables
	programs.nix-ld.enable = true;

	# List services that you want to enable:

	# Enable the OpenSSH daemon.
	# services.openssh.enable = true;

	# Enable touchpad support (enabled default in most desktopManager).
	# services.xserver.libinput.enable = true;

	services.xserver = {
		enable = true;

		layout = "au";
		xkbVariant = "";
		xkbOptions = "ctrl:nocaps";

		# ===== using only i3 =====
		# desktopManager.xterm.enable = false;
		# displayManager = {
		# 	defaultSession = "none+i3";
		# 	lightdm.enable = true;
		# };
		# windowManager.i3.enable = true;

		# ===== using xfce+i3 =====
		desktopManager = {
			xterm.enable = false;
			xfce = {
				enable = true;
				noDesktop = true;
				enableXfwm = false;
			};
		};

		displayManager = {
			defaultSession = "xfce+i3";
			lightdm.enable = true;
		};

		windowManager = {
			i3.enable = true;
		};
	};

	# services.udisks2.enable = true;

	# Enable CUPS to print documents.
	# services.printing.enable = true;

	# Open ports in the firewall.
	# networking.firewall.allowedTCPPorts = [ ... ];
	# networking.firewall.allowedUDPPorts = [ ... ];
	# Or disable the firewall altogether.
	# networking.firewall.enable = false;

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "23.11"; # Did you read the comment?
}
