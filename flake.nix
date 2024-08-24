{
  description = "My NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, ... } @ inputs:
    let
      pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux.pkgs;

      overlays = import ./overlays { inherit inputs; };

      mkSystem = import ./lib/mksystem.nix {
        inherit inputs overlays;
      };
    in
    {
      devShells.x86_64-linux.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          nil
          lua-language-server
          stylua
          gnumake
        ];
      };

      nixosConfigurations = {
        thorin = mkSystem "thorin" {
          system = "x86_64-linux";
          user = "brianaung";
          hardware = "framework-13-7040-amd";
        };
        gimli = mkSystem "gimli" {
          system = "x86_64-linux";
          user = "brianaung";
          hardware = "lenovo-ideapad-slim-5";
        };
      };

      formatter.x86_64-linux = pkgs.nixpkgs-fmt;
    };
}
