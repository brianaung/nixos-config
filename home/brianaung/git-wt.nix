{ pkgs, ... }:
let
  git-wt = pkgs.writeShellScriptBin "git-wt" ''
    #!/bin/bash

    if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        echo "fatal: not a git repository (or any of the parent directories): .git"
        exit 1
    fi

    if [ "$1" = "switch" ]; then
        if [ -z "$2" ]; then
            echo "fatal: missing worktree argument"
            exit 1
        fi

        target_path=$(git worktree list | awk -v name="$2" '$0 ~ name {print $1; exit}')
        if [ -n "$target_path" ] && [ -d "$target_path" ]; then
            echo "Switched to worktree '$2'"
            cd "$target_path" && exec $SHELL
        else
            echo "fatal: invalid worktree '$2'"
        fi
    else
        exec git worktree "$@"
    fi
  '';
in
{
  home.packages = [ git-wt ];
}
