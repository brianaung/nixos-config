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

  outputs = { nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations = {
        default = nixpkgs.lib.nixosSystem {
          modules = [ ./system/nixos/configuration.nix ];
        };
      };

      # I like to use standalone home-manager than a nixos module
      homeConfigurations = {
        default = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { 
            inherit inputs; 
            root = ./.;
          };
          modules = [ ./home/default.nix ];
        };
      };
    };
}
