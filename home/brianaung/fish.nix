{ ... }: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      if status is-interactive
      and not set -q TMUX
        exec tmux new-session -A -s main
      end

      fish_vi_key_bindings
      bind -M insert \cy accept-autosuggestion

      set fish_color_cwd yellow

      set -g __fish_git_prompt_show_informative_status true
      set -g __fish_git_prompt_showcolorhints true

      alias vi=nvim
    '';
  };
}
