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
		autorandr
		xcape
		pulseaudio
		pavucontrol
	];

	services.xserver = {
		enable = true;
		xkb = {
			layout = "au";
			variant = "";
		};

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
			sessionCommands = ''
				setxkbmap -option 'caps:ctrl_modifier'
				xcape -e 'Caps_Lock=Escape'
			'';
		};
		windowManager.i3.enable = true;
	};

	virtualisation.docker.enable = true;

	networking.extraHosts = ''
		192.168.56.56  cms.simonds.test
	'';

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "23.11"; # Did you read the comment?
}
