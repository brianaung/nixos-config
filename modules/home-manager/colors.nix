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
    Black = "1c1c1c"; # 0
    Red = "D75F5F"; # 1
    Green = "87AF87"; # 2
    Yellow = "AFAF87"; # 3
    Blue = "5F87AF"; # 4
    Magenta = "AF87AF"; # 5
    Cyan = "5F8787"; # 6
    White = "9E9E9E"; # 7

    BrightBlack = "767676"; # 8
    BrightRed = "D7875F"; # 9
    BrightGreen = "AFD7AF"; # 10
    BrightYellow = "D7D787"; # 11
    BrightBlue = "87AFD7"; # 12
    BrightMagenta = "D7AFD7"; # 13
    BrightCyan = "87AFAF"; # 14
    BrightWhite = "BCBCBC"; # 15

    Background = Black;
    Foreground = White;
  };

  # 232 - 255 (grayscale: darkest -> lightest)
  # 235 #262626
  # 240 #585858
  # 245 #8a8a8a
  # 250 #bcbcbc
}
