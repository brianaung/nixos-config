{ lib
, stdenv
, fetchFromGitHub
, pkg-config
, wayland
, wayland-protocols
, wayland-scanner
, pixman
, fcft
}:

stdenv.mkDerivation {
  pname = "dwlb";
  version = "1";

  src = fetchFromGitHub {
    owner = "kolunmi";
    repo = "dwlb";
    rev = "0daa1c1fdd82c4d790e477bf171e23ca2fdfa0cb";
    hash = "sha256-Bu20IqRwBP1WRBgbcEQU4Q2BZ2FBnVaySOTsCn0iSSE=";
  };

  nativeBuildInputs = [ pkg-config wayland-scanner ];

  buildInputs = [ wayland wayland-protocols pixman fcft ];

  installFlags = [ "PREFIX=$(out)" ];

  meta = {
    description = "Feature-Complete Bar for DWL";
    homepage = "https://github.com/kolunmi/dwlb";
    license = lib.licenses.gpl3Plus;
  };
}
