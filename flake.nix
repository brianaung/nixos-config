{
  description = "Brian's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    claude-code.url = "github:sadjow/claude-code-nix";
    codex-cli-nix.url = "github:sadjow/codex-cli-nix";
    kairos = {
      url = "git+ssh://git@github.com/PSDesign/kairos";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nix-darwin, ... }@inputs:
    let
      inherit (nixpkgs.lib) optionals;

      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = function: nixpkgs.lib.genAttrs systems (system: function system);

      overlays = import ./overlays { inherit inputs; };
      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;

      mkSystem = host: { user, system, hardware ? null, darwin ? false, work ? false }:
        let
          systemFunc = if darwin then nix-darwin.lib.darwinSystem else nixpkgs.lib.nixosSystem;
          home-manager = if darwin then inputs.home-manager.darwinModules else inputs.home-manager.nixosModules;
        in
        systemFunc {
          inherit system;
          specialArgs = { inherit inputs user; };

          modules = [
            { nixpkgs.overlays = [ overlays ]; }

            ./hosts/${host}/configuration.nix

            home-manager.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.${user} = import ./home/${user}/home.nix;
                sharedModules = [ homeManagerModules ]
                  ++ optionals work [
                  inputs.kairos.homeManagerModules.default
                  { services.kairos.enable = true; }
                ];
                extraSpecialArgs = { inherit inputs darwin; };
              };
            }

            {
              environment.systemPackages = [
                inputs.neovim-nightly-overlay.packages.${system}.default
                inputs.codex-cli-nix.packages.${system}.default
                inputs.claude-code.packages.${system}.default
              ];
            }
          ]
          ++ optionals (!darwin) [ nixosModules ]
          ++ optionals (hardware != null) [ inputs.nixos-hardware.nixosModules.${hardware} ];
        };
    in
    {
      nixosConfigurations.thorin = mkSystem "thorin" {
        user = "brianaung";
        hardware = "framework-13-7040-amd";
        system = "x86_64-linux";
        work = true;
      };

      nixosConfigurations.gimli = mkSystem "gimli" {
        user = "brianaung";
        hardware = "lenovo-ideapad-slim-5";
        system = "x86_64-linux";
      };

      darwinConfigurations.dain = mkSystem "dain" {
        user = "brianaung";
        system = "aarch64-darwin";
        darwin = true;
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
