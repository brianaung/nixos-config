NIX_NAME ?= lenovo-5-amd

bootstrap:
	parted /dev/sda -- mklabel gpt; \
	parted /dev/sda -- mkpart root ext4 512MB -8GB; \
	parted /dev/sda -- mkpart swap linux-swap -8GB 100\%; \
	parted /dev/sda -- mkpart ESP fat32 1MB 512MB; \
	parted /dev/sda -- set 3 esp on; \
	sleep 1; \
	mkfs.ext4 -L nixos /dev/sda1; \
	mkswap -L swap /dev/sda2; \
	swapon /dev/sda2; \
	mkfs.fat -F 32 -n boot /dev/sda3; \
	sleep 1; \
	mount /dev/disk/by-label/nixos /mnt; \
	mkdir -p /mnt/boot; \
	mount /dev/disk/by-label/boot /mnt/boot; \
	nixos-generate-config --root /mnt; \
	sed -i '/system\.stateVersion = .*/a \
		nix.settings.experimental-features = [ "nix-command" "flakes" ]; \
		nixpkgs.config.allowUnfree = true; \
		nixpkgs.config.permittedInsecurePackages = [ "electron-25.9.0" ]; \
		networking.networkmanager.enable = true; \
		environment.systemPackages = with pkgs; [ \
			vim \
		]; \
		users.users.root.initialPassword = \"root\";\n \
	' /mnt/etc/nixos/configuration.nix; \
	nixos-install --no-root-passwd && reboot;

switch:
	sudo nixos-rebuild switch --flake ".#${NIX_NAME}"

update:
	nix flake update

upgrade: update switch

clean:
	nix-collect-garbage -d && sudo nix-collect-garbage -d

.PHONY: bootstrap switch update upgrade clean
