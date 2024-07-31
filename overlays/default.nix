{ inputs }:
final: prev: {
  unstable = import inputs.nixpkgs-unstable {
    system = final.system;
    config.allowUnfree = true;
  };

  apple-fonts = final.callPackage ../pkgs/apple-fonts.nix { };

  dwlb = final.callPackage ../pkgs/dwlb.nix { };
}
