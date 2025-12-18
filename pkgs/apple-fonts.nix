{ lib, stdenv, p7zip, fetchurl }:

stdenv.mkDerivation rec {
  pname = "apple-fonts";
  version = "1";

  pro = fetchurl {
    url = "https://devimages-cdn.apple.com/design/resources/download/SF-Pro.dmg";
    sha256 = "sha256-Lk14U5iLc03BrzO5IdjUwORADqwxKSSg6rS3OlH9aa4=";
  };

  compact = fetchurl {
    url = "https://devimages-cdn.apple.com/design/resources/download/SF-Compact.dmg";
    sha256 = "sha256-CMNP+sL5nshwK0lGBERp+S3YinscCGTi1LVZVl+PuOM=";
  };

  mono = fetchurl {
    url = "https://devimages-cdn.apple.com/design/resources/download/SF-Mono.dmg";
    hash = "sha256-bUoLeOOqzQb5E/ZCzq0cfbSvNO1IhW1xcaLgtV2aeUU=";
  };

  ny = fetchurl {
    url = "https://devimages-cdn.apple.com/design/resources/download/NY.dmg";
    sha256 = "sha256-HC7ttFJswPMm+Lfql49aQzdWR2osjFYHJTdgjtuI+PQ=";
  };

  nativeBuildInputs = [ p7zip ];

  setSourceRoot = "sourceRoot=`pwd`";

  unpackPhase = ''
    7z x '${pro}'
    cd SFProFonts
    7z x 'SF Pro Fonts.pkg'
    7z x 'Payload~'
    cd ..

    7z x '${compact}'
    cd SFCompactFonts
    7z x 'SF Compact Fonts.pkg'
    7z x 'Payload~'
    cd ..

    7z x '${mono}'
    cd SFMonoFonts
    7z x 'SF Mono Fonts.pkg'
    7z x 'Payload~'
    cd ..

    7z x '${ny}'
    cd NYFonts
    7z x 'NY Fonts.pkg'
    7z x 'Payload~'
    cd ..
  '';

  installPhase = ''
    mkdir -p $out/share/fonts
    mkdir -p $out/share/fonts/opentype
    mkdir -p $out/share/fonts/truetype
    find -name \*.otf -exec mv {} $out/share/fonts/opentype/ \;
    find -name \*.ttf -exec mv {} $out/share/fonts/truetype/ \;
  '';

  meta = {
    description = "Apple San Francisco, New York font";
    homepage = "https://developer.apple.com/fonts/";
    license = lib.licenses.unfree;
  };
}
