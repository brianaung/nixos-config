{
  description = "Brian's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forAllSystems = function: nixpkgs.lib.genAttrs systems (system: function system);

      overlays = import ./overlays { inherit inputs; };
      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;

      mkSystem = host: { user, hardware, system }:
        nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs user; };
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
                extraSpecialArgs = { 
                  inherit inputs; 
                };
              };
            }

            # Hardware
            inputs.nixos-hardware.nixosModules.${hardware}

            {
              environment.systemPackages = [
                inputs.neovim-nightly-overlay.packages.${system}.default
              ];
            }
          ];
        };
    in
    {
      nixosConfigurations = {
        thorin = mkSystem "thorin" {
          user = "brianaung";
          hardware = "framework-13-7040-amd";
          system = "x86_64-linux";
        };
        gimli = mkSystem "gimli" {
          user = "brianaung";
          hardware = "lenovo-ideapad-slim-5";
          system = "x86_64-linux";
        };
      };

      devShells = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.mkShell {
            buildInputs = with pkgs; [
              nil
              lua-language-server
              stylua
              gnumake
            ];
          };
        });

      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixpkgs-fmt);
    };
}
