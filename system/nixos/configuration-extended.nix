{ pkgs, ... }:

{
	imports =
		[ # import the main configuration.
			/etc/nixos/configuration.nix
		];

	# enable flakes
	nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # packages I need only for this system
	environment.systemPackages = with pkgs; [
		feh
		picom
		arandr
		autorandr
		pulseaudio
		pavucontrol
		brightnessctl

		# I don't really need this tbh. I will only call them using i3 keybinds so.
		# dex
		# xss-lock
		# network-manager-applet
		# dmenu
		# i3status
	];

	programs = {
		zsh.enable = true;
		# i need this to be able to run non-nix executables
		nix-ld.enable = true;
	};

	services = {
		xserver = {
			enable = true;
			# ===== using only i3 =====
			# desktopManager.xterm.enable = false;
			# displayManager.defaultSession = "none+i3";
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
			displayManager.defaultSession = "xfce+i3";
			windowManager.i3.enable = true;
		};

		udisks2.enable = true;
	};

	# set default shell
	users.users.brianaung.shell = pkgs.zsh;
}
