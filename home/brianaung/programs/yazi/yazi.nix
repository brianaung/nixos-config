{ pkgs, ... }: {
  programs.yazi = {
    enable = true;
    package = pkgs.unstable.yazi;
    keymap = {
      manager.prepend_keymap = [
        { on = [ "<Esc>" ]; run = "quit"; }
        { on = [ "-" ]; run = "leave"; }
        { on = [ "<Enter>" ]; run = "plugin --sync smart-enter"; }
      ];
    };
    plugins = {
      smart-enter = ./smart-enter.yazi;
    };
  };
}

