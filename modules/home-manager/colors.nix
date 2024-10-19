{ lib, ... }:
let
  colornames = [
    "Black"
    "Red"
    "Green"
    "Yellow"
    "Blue"
    "Magenta"
    "Cyan"
    "White"

    "BrightBlack"
    "BrightRed"
    "BrightGreen"
    "BrightYellow"
    "BrightBlue"
    "BrightMagenta"
    "BrightCyan"
    "BrightWhite"

    "Background"
    "Foreground"

  ];
in
{
  options.colors = builtins.listToAttrs (map
    (c: {
      name = c;
      value = lib.mkOption { type = lib.types.str; };
    })
    colornames);

  config.colors = rec {
    Black = "000000"; # 0
    Red = "800000"; # 1
    Green = "008000"; # 2
    Yellow = "808000"; # 3
    Blue = "000080"; # 4
    Magenta = "800080"; # 5
    Cyan = "008080"; # 6
    White = "c0c0c0"; # 7

    BrightBlack = "808080"; # 8
    BrightRed = "ff0000"; # 9
    BrightGreen = "00ff00"; # 10
    BrightYellow = "ffff00"; # 11
    BrightBlue = "0000ff"; # 12
    BrightMagenta = "ff00ff"; # 13
    BrightCyan = "00ffff"; # 14
    BrightWhite = "ffffff"; # 15

    Background = BrightWhite;
    Foreground = Black;
  };

  # 232 - 255 (grayscale: darkest -> lightest)
  # 235 #262626
  # 240 #585858
  # 245 #8a8a8a
  # 250 #bcbcbc
}
