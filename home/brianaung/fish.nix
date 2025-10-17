{ ... }: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      fish_vi_key_bindings
      bind -M insert \cy accept-autosuggestion
      for m in default insert
        bind -M $m \cf tmux-sessionizer
      end

      set fish_color_cwd yellow

      set -g __fish_git_prompt_show_informative_status true
      set -g __fish_git_prompt_showcolorhints true

      alias vi=nvim
    '';
  };
}
