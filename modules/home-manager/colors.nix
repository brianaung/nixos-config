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
    Black = "242931";
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

    # Kanagawa Dragon
    # Black = "181616";
    # Red = "c4746e";
    # Green = "8a9a7b";
    # Yellow = "c4b28a";
    # Blue = "8ba4b0";
    # Magenta = "a292a3";
    # Cyan = "8ea4a2";
    # White = "c5c9c5";
    # BrightBlack = "aba69c";
    # BrightRed = "E46876";
    # BrightGreen = "87a987";
    # BrightYellow = "E6C384";
    # BrightBlue = "7FB4CA";
    # BrightMagenta = "938AA9";
    # BrightCyan = "7AA89F";
    # BrightWhite = "c8c093";

    Background = Black;
    Foreground = White;
  };

  # 232 - 255 (grayscale: darkest -> lightest)
  # 235 #262626
  # 240 #585858
  # 245 #8a8a8a
  # 250 #bcbcbc
}
