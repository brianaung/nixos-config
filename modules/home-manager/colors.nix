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
    # Nord
    # Black = "242931";
    # Red = "bf616a";
    # Green = "a3be8c";
    # Yellow = "ebcb8b";
    # Blue = "81a1c1";
    # Magenta = "b48ead";
    # Cyan = "88c0d0";
    # White = "e5e9f0";
    # BrightBlack = "4c566a";
    # BrightRed = "bf616a";
    # BrightGreen = "a3be8c";
    # BrightYellow = "ebcb8b";
    # BrightBlue = "81a1c1";
    # BrightMagenta = "b48ead";
    # BrightCyan = "8fbcbb";
    # BrightWhite = "eceff4";

    # Tokyonight
    # Black = "222436";
    # Red = "ff757f";
    # Green = "c3e88d";
    # Yellow = "ffc777";
    # Blue = "82aaff";
    # Magenta = "c099ff";
    # Cyan = "86e1fc";
    # White = "828bb8";
    # BrightBlack = "444a73";
    # BrightRed = "ff757f";
    # BrightGreen = "c3e88d";
    # BrightYellow = "ffc777";
    # BrightBlue = "82aaff";
    # BrightMagenta = "c099ff";
    # BrightCyan = "86e1fc";
    # BrightWhite = "c8d3f5";

    # Rose Pine
    Black = "191724";
    Red = "eb6f92";
    Green = "9ccfd8";
    Yellow = "f6c177";
    Blue = "31748f";
    Magenta = "c4a7e7";
    Cyan = "ebbcba";
    White = "e0def4";
    BrightBlack = "47435d";
    BrightRed = "ff98ba";
    BrightGreen = "c5f9ff";
    BrightYellow = "ffeb9e";
    BrightBlue = "5b9ab7";
    BrightMagenta = "eed0ff";
    BrightCyan = "ffe5e3";
    BrightWhite = "fefcff";

    Background = Black;
    Foreground = BrightWhite;
  };
}
