{ ... }:
{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "Terminess Nerd Font:size=14";
      };
      colors = {
        background = "ffffffff";
        text = "000000ff";
        selection = "00000022";
        selectionText = "000000aa";
        border = "000000ff";
      };
      border = {
        radius = 0;
      };
    };
  };
}
