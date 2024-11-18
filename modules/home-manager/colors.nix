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
    # Black = "000000"; # 0
    # Red = "f7768e";
    # Green = "9ece6a";
    # Yellow = "e0af68";
    # Blue = "7aa2f7";
    # Magenta = "bb9af7";
    # Cyan = "7dcfff";
    # White = "a9b1d6";
    #
    # BrightBlack = "414868";
    # BrightRed = "f7768e";
    # BrightGreen = "9ece6a";
    # BrightYellow = "e0af68";
    # BrightBlue = "7aa2f7";
    # BrightMagenta = "bb9af7";
    # BrightCyan = "7dcfff";
    # BrightWhite = "c0caf5";

    Black = "2e3440";
    Red = "bf616a";
    Green = "a3be8c";
    Yellow = "ebcb8b";
    Blue = "81a1c1";
    Magenta = "b48ead";
    Cyan = "88c0d0";
    White = "e5e9f0";

    BrightBlack = "4c566a";
    BrightRed = "bf616a";
    BrightGreen = "a3be8c";
    BrightYellow = "ebcb8b";
    BrightBlue = "81a1c1";
    BrightMagenta = "b48ead";
    BrightCyan = "8fbcbb";
    BrightWhite = "eceff4";

    Background = Black;
    Foreground = White;
  };

  # 232 - 255 (grayscale: darkest -> lightest)
  # 235 #262626
  # 240 #585858
  # 245 #8a8a8a
  # 250 #bcbcbc
}
