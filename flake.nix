{
	description = "My dotfiles flake.";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		nix-colors.url = "github:misterio77/nix-colors";
	};

	outputs = { nixpkgs, home-manager, ... }@inputs: let
		mkSystem = import ./lib/mksystem.nix {
			inherit nixpkgs inputs;
		};
	in {
		nixosConfigurations = {
			lenovo-5-amd = mkSystem "lenovo-5-amd" {
				system = "x86_64-linux";
				user = "brianaung";
			};

			# vm-x86 = mkSystem "vm-x86" {
			# 	system = "x86_64-linux";
			# 	user = "brianaung";
			# };
		};
	};
}
