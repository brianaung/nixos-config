{
  description = "Brian's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forAllSystems = function: nixpkgs.lib.genAttrs systems (system: function nixpkgs.legacyPackages.${system});

      overlays = import ./overlays { inherit inputs; };
      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;

      mkSystem = host: { user, hardware }:
        nixpkgs.lib.nixosSystem {
          # specialArgs = { inherit inputs; };
          modules = [
            # Overlays
            { nixpkgs.overlays = [ overlays ]; }

            # NixOS
            ./hosts/${host}/configuration.nix
            nixosModules

            # Home Manager
            inputs.home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.${user} = import ./home/${user}/home.nix;
                sharedModules = [ homeManagerModules ];
                extraSpecialArgs = { inherit inputs; };
              };
            }

            # Others
            inputs.nixos-cosmic.nixosModules.default
            inputs.nixos-hardware.nixosModules.${hardware}
          ];
        };
    in
    {
      nixosConfigurations = {
        thorin = mkSystem "thorin" {
          user = "brianaung";
          hardware = "framework-13-7040-amd";
        };
        gimli = mkSystem "gimli" {
          user = "brianaung";
          hardware = "lenovo-ideapad-slim-5";
        };
      };

      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShell {
          buildInputs = with pkgs; [
            nil
            lua-language-server
            stylua
            gnumake
          ];
        };
      });

      formatter = forAllSystems (pkgs: pkgs.nixpkgs-fmt);
    };
}
