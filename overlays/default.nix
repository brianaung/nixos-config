{ inputs }:
final: prev: {
  unstable = import inputs.nixpkgs-unstable {
    system = final.system;
    config.allowUnfree = true;
  };

  apple-fonts = final.callPackage ../pkgs/apple-fonts.nix { };

  nightly-claude-code = prev.claude-code.overrideAttrs (old: rec {
    version = "2.0.0";
    src = prev.fetchzip {
        url = "https://registry.npmjs.org/@anthropic-ai/claude-code/-/claude-code-${version}.tgz";
        hash = "sha256-uHU9SZso0OZkbcroaVqqVoDvpn28rZVc6drHBrElt5M=";
    };
  });

  # nightly-awesome = prev.awesome.overrideAttrs (old: rec {
  #   src = prev.fetchFromGitHub {
  #     owner = "awesomeWM";
  #     repo = "awesome";
  #     rev = "f009815cb75139acf4d8ba3c1090bf2844d13f4c";
  #     sha256 = "Tw5OZNe+FdqRvPdaWviDFHDCJ7KFvsBi12WryZt+PEs=";
  #   };
  #   patches = [];
  # });

  # dwl-custom = (final.unstable.dwl.overrideAttrs (oldAttrs: {
  #   patches = [
  #     ../patches/dwl/autostart.patch
  #   ];

  #   buildInputs = with final.unstable; [
  #     fcft
  #     libdrm
  #   ] ++ oldAttrs.buildInputs;
  # })).override{ configH = ./config.h; };

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
