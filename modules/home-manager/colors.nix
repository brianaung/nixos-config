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
  ];
in
{
  options.colors = builtins.listToAttrs (map
    (c: {
      name = c;
      value = lib.mkOption { type = lib.types.str; };
    })
    colornames);

  config.colors = {
    Black = "000000"; # 0
    Red = "ff4136"; # 1
    Green = "19a974"; # 2
    Yellow = "ffb700"; # 3
    Blue = "357edd"; # 4
    Magenta = "ff41b4"; # 5
    Cyan = "a463f2"; # 6
    White = "ffffff"; # 7

    BrightBlack = "777777"; # 8
    BrightRed = "ff725c"; # 9
    BrightGreen = "19a974"; # 10
    BrightYellow = "ffd700"; # 11
    BrightBlue = "96ccff"; # 12
    BrightMagenta = "ff41b4"; # 13
    BrightCyan = "a463f2"; # 14
    BrightWhite = "f4f4f4"; # 15
  };

  # 232 - 255 (grayscale: darkest -> lightest)
  # 235 #262626
  # 240 #585858
  # 245 #8a8a8a
  # 250 #bcbcbc
}
