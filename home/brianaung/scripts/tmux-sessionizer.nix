{ pkgs, ... }:
let
  tmux-sessionizer = pkgs.writeShellScriptBin "tmux-sessionizer" ''
    #!/usr/bin/env bash

    # theprimeagen so good

    if [[ $# -eq 1 ]]; then
    		selected=$1
    else
    		selected=$(find /data/projects /data/playground ~/work ~/projects ~/playground ~/.config/nixos-config -mindepth 0 -maxdepth 1 -type d | fzf)
    fi

    if [[ -z $selected ]]; then
    		exit 0
    fi

    selected_name=$(basename "$selected" | tr . _)
    tmux_running=$(pgrep tmux)

    # we're not in tmux, so just create(or)attach to the selected session
    if [[ -z $TMUX ]] || [[ -z tmux_running ]]; then
    		tmux new-session -A -s $selected_name -c $selected
    		exit 0
    fi

    # we're in tmux, but session doesn't exist, so create a detached one
    if ! tmux has-session -t=$selected_name 2> /dev/null; then
    		tmux new-session -ds $selected_name -c $selected
    fi
    # then we switch to selected session
    tmux switch-client -t $selected_name
  '';
in
{
  home.packages = [ tmux-sessionizer ];
}
