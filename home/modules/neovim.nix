{ pkgs, root, ... }:

{
  # nix is cool, but i still like writing neovim config in lua. maybe i will switch one day.
  # xdg.configFile."nvim".source = root + /xdg_config/nvim;
  xdg.configFile."nvim".source = ../../xdg_config/nvim;

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
}
