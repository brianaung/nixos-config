{ config, lib, pkgs, ... }:

{
  imports =
	[
	  ./hardwares/dell-intel.nix
	  ./nixos-shared.nix
	];

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	sound.enable = true;
	hardware.pulseaudio.enable = false;
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
	};

	# Enable OpenGL
	hardware.opengl = {
		enable = true;
		driSupport = true;
		driSupport32Bit = true;
	};

	services.xserver.videoDrivers = ["nvidia"];

	hardware.nvidia = {
		package = config.boot.kernelPackages.nvidiaPackages.stable;
		modesetting.enable = true; # required
		open = false;
		nvidiaSettings = true;
		prime = {
			sync.enable = true;
			intelBusId = "PCI:0:2:0";
			nvidiaBusId = "PCI:1:0:0";
		};
	};

	system.stateVersion = "23.11"; # Did you read the comment?
}

