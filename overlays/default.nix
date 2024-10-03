{ inputs }:
final: prev: {
  unstable = import inputs.nixpkgs-unstable {
    system = final.system;
    config.allowUnfree = true;
  };

  apple-fonts = final.callPackage ../pkgs/apple-fonts.nix { };

  # wip
  # strawberry = final.unstable.strawberry.overrideAttrs (oldAttrs: rec {
  #   version = "1.1.3";
  #   src = oldAttrs.src.override {
  #     rev = version;
  #     hash = "sha256-yca1BJWhSUVamqSKfvEzU3xbzdR+kwfSs0pyS08oUR0=";
  #   };
  #   buildInputs = oldAttrs.buildInputs ++ [ final.unstable.gst_all_1.gst-plugins-rs ];
  #   patches = (oldAttrs.patches or []) ++ [
  #     (prev.fetchpatch {
  #       name = "1801.patch";
  #       url = "https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs/-/merge_requests/1801.patch";
  #       hash = "sha256-/HLZTViHGimUonaZ9dsn+ZJA2cia+4UqM45V6GraDKs=";
  #     })
  #   ];
  # });
}
