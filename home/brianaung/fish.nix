{ ... }: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      fish_vi_key_bindings
      bind -M insert \cy accept-autosuggestion

      set fish_color_cwd yellow

      set -g __fish_git_prompt_show_informative_status true
      set -g __fish_git_prompt_showcolorhints true

      alias vi=nvim
    '';
  };
}
