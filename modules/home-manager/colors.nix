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
    Red = "b4637a"; # 1
    Green = "286983"; # 2
    Yellow = "f6c177"; # 3
    Blue = "56949f"; # 4
    Magenta = "907aa9"; # 5
    Cyan = "d7827e"; # 6
    White = "faf4ed"; # 7

    BrightBlack = "6e6a86"; # 8
    BrightRed = "eb6f92"; # 9
    BrightGreen = "31748f"; # 10
    BrightYellow = "ea9d34"; # 11
    BrightBlue = "9ccfd8"; # 12
    BrightMagenta = "907aa9"; # 13
    BrightCyan = "d7827e"; # 14
    BrightWhite = "ffffff"; # 15

    Background = Black;
    Foreground = White;
  };

  # 232 - 255 (grayscale: darkest -> lightest)
  # 235 #262626
  # 240 #585858
  # 245 #8a8a8a
  # 250 #bcbcbc
}
