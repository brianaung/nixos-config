{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    tmux
    sesh
    ripgrep
    fd
    bat
    jq
    pandoc
    btop
  ];
  environment.shells = [ pkgs.fish ];
  programs.fish.enable = true;

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Set session variables.
  environment.variables = {
    EDITOR = "nvim";
  };

  programs.direnv.enable = true;
}
