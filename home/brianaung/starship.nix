{ ... }: {
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      # Prompt format with cloud tools and line break
      format = "$username$hostname$directory$git_branch$git_status$line_break$character";

      # Vi mode character with [N] and [I] indicators
      character = {
        success_symbol = "\\[I\\] [>](bold green)";
        error_symbol = "\\[I\\] [>](bold red)";
        vimcmd_symbol = "\\[N\\] [>](bold green)";
        vimcmd_visual_symbol = "\\[V\\] [>](bold green)";
        vimcmd_replace_symbol = "\\[R\\] [>](bold green)";
        vimcmd_replace_one_symbol = "\\[R\\] [>](bold green)";
      };

      # Username - always show in yellow
      username = {
        show_always = true;
        format = "[$user]($style)";
        style_user = "bold yellow";
      };

      # Hostname - always show in yellow
      hostname = {
        ssh_only = false;
        format = "[@$hostname]($style) ";
        style = "bold yellow";
      };

      # Directory - fish-like with abbreviation and [] brackets
      directory = {
        format = "\\[[$path]($style)\\] ";
        style = "bold cyan";
        truncation_length = 3;
        truncate_to_repo = true;
        fish_style_pwd_dir_length = 1;
      };

      # Git branch - green branch name
      git_branch = {
        format = "\\([$branch](bold green)";
        style = "bold green";
      };

      # Git status - detailed with red symbols
      git_status = {
        format = "([ $all_status$ahead_behind](bold red))\\) ";
        style = "bold red";
        conflicted = "=";
        ahead = "⇡\${count}";
        behind = "⇣\${count}";
        diverged = "⇕⇡\${ahead_count}⇣\${behind_count}";
        untracked = "?";
        modified = "!";
        staged = "+";
        renamed = "»";
        deleted = "✘";
      };
    };
  };
}
