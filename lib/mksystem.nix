{ inputs, overlays }:
host:
{ system
, user
, hardware ? null
,
}:
let
  hostConfig = ../host/${host}.nix;
  homeConfig = ../home/common.nix;

  systemFunc = inputs.nixpkgs.lib.nixosSystem;
in
systemFunc rec {
  inherit system;

  specialArgs = {
    inputs = inputs;
    currentUser = user;
    currentHost = host;
  };

  modules = [
    { nixpkgs.overlays = [ overlays ]; }

    # Import the host's configuration.nix.
    hostConfig

    # Hardware quirks.
    (if !(builtins.isNull hardware) then inputs.nixos-hardware.nixosModules.${hardware} else { })

    # Home manager module to manage user program configurations.
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.${user} = homeConfig;
      home-manager.extraSpecialArgs = {
        inherit inputs;
      };
    }
  ];
}
