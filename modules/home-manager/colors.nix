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
    Black = "1C1C1C";
    BrightBlack = "767676";
    Red = "D75F5F";
    BrightRed = "D7875F";
    Green = "87AF87";
    BrightGreen = "AFD7AF";
    Yellow = "AFAF87";
    BrightYellow = "D7D787";
    Blue = "658594";
    BrightBlue = "87AFD7";
    Magenta = "AF87AF";
    BrightMagenta = "D7AFD7";
    Cyan = "5F8787";
    BrightCyan = "87AFAF";
    White = "DCD7BA";
    BrightWhite = "BCBCBC";
  };
}
