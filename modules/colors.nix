{ lib, ... }:
let
  colornames = [
    "Black"
    "BrightBlack"
    "Red"
    "BrightRed"
    "Green"
    "BrightGreen"
    "Yellow"
    "BrightYellow"
    "Blue"
    "BrightBlue"
    "Magenta"
    "BrightMagenta"
    "Cyan"
    "BrightCyan"
    "White"
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
    Black = "000000";
    BrightBlack = "262424";
    Red = "a62434";
    BrightRed = "cc2128";
    Green = "718b44";
    BrightGreen = "32a457";
    Yellow = "e6b532";
    BrightYellow = "fff12d";
    Blue = "2f4994";
    BrightBlue = "32338e";
    Magenta = "8c2465";
    BrightMagenta = "ca0088";
    Cyan = "2c7962";
    BrightCyan = "00acec";
    White = "e6e6e7";
    BrightWhite = "ffffff";
  };
}
