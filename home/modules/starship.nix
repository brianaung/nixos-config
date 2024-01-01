{ pkgs, ... }:

{
  programs.starship = {
    enable = true;
    package = pkgs.starship;

    settings = {
      command_timeout = 2000;
      add_newline = false;
      format = "$character$directory$git_branch$git_status";
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
        vimcmd_symbol = "[V](bold green)";
      };
      directory = {
        truncation_length = 1;
      };
    };
  };
}
