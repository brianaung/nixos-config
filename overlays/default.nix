{ inputs }:
final: prev: {
  unstable = import inputs.nixpkgs-unstable {
    system = final.system;
    config.allowUnfree = true;
  };

  apple-fonts = final.callPackage ../pkgs/apple-fonts.nix { };

  dwlb = final.callPackage ../pkgs/dwlb.nix { };

  someblocks = final.callPackage ../pkgs/someblocks.nix { };

  dwl = (prev.dwl.overrideAttrs (oldAttrs: rec {
    version = "0.7-rc1";
    patches = [
      ../home/dwl/autostart.patch
    ];
  })).override{ conf = ../home/dwl/config.h; };
}
