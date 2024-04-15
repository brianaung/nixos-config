{
  nixos-hardware,
  nixpkgs,
  home-manager,
  nix-colors,
}:

host:
{
  system,
  user,
  hardware ? null,
}:
let
  hostConfig = ../host/${host}.nix;
  homeConfig = ../home/default.nix;

  systemFunc = nixpkgs.lib.nixosSystem;
in
systemFunc rec {
  inherit system;

  specialArgs = {
    currentUser = user;
    currentHost = host;
  };

  modules = [
    # Import the host's configuration.nix.
    hostConfig

    # Hardware quirks.
    (if !(builtins.isNull hardware) then nixos-hardware.nixosModules.${hardware} else { })

    # Home manager module to manage user program configurations.
    home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.${user} = homeConfig;
      home-manager.extraSpecialArgs = {
        inherit nix-colors;
      };
    }
  ];
}
