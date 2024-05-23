{
  description = "My NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs =
    { self
    , nixpkgs
    , nixos-hardware
    , home-manager
    , nix-colors
    , ...
    } @ inputs:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux.pkgs;
      mkSystem = import ./lib/mksystem.nix {
        inherit
          nixos-hardware
          nixpkgs
          home-manager
          nix-colors
          ;
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
