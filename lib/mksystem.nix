# This function creates a NixOS system based on a particular architecture and user.
{ nixpkgs, inputs }:

name:
{
	system,
	user
}:

let
	home-manager = inputs.home-manager.nixosModules;
	systemFunc = nixpkgs.lib.nixosSystem;
in systemFunc rec {
	inherit system;
	modules = [
		../machines/${name}.nix			# machine config
		../users/${user}/nixos.nix	# os user config (defines user account, etc.)
		# home-manager module
		home-manager.home-manager {
			home-manager.useGlobalPkgs = true;
			home-manager.useUserPackages = true;
			home-manager.users.${user} = import ../users/${user}/home.nix;
			home-manager.extraSpecialArgs = {
				inherit inputs user;
			};
		}
	];
}
