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
    pkgs = nixpkgs.legacyPackages.x86_64-linux.pkgs;
		mkSystem = import ./lib/mksystem.nix {
			inherit nixpkgs inputs;
		};
	in {
		devShells.x86_64-linux.default = pkgs.mkShell {
			name = "My dotfiles build environment";
			buildInputs = with pkgs; [
				go
				nodejs_18
				cargo
				stylua
			];
			shellHook = ''
				echo "Welcome in $name"
			'';
		};

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
