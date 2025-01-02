{ ... }: {
  programs.tmux = {
    enable = true;
    extraConfig = ''
      set -g default-terminal "tmux-256color"

      set -g history-limit 10000
      set -s escape-time 0

      setw -g mode-keys vi
      set -g mouse on

      # change prefix
      unbind c-b
      set -g prefix c-a
      bind c-a send-prefix

      #ui
      # set -g status-position top
      set -g status-left-length 200
      set -g status-right-length 200
      # set -g status-style bg=white,fg=black

      bind-key r source-file ~/.config/tmux/tmux.conf \; display-message "tmux.conf reloaded"

      bind -T copy-mode-vi v send-keys -X begin-selection
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'xclip -in -selection clipboard'

      # start new panes and windows in curr directory
      bind-key = split-window -h -c "#{pane_current_path}"
      bind-key - split-window -v -c "#{pane_current_path}"
      bind-key c new-window -c "#{pane_current_path}"

      # windows
      set -g base-index 1
      set -g renumber-windows on
      set -g automatic-rename on

      # smart vim-tmux navigation
      is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
          | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?|fzf)(diff)?$'"
      bind-key -n 'c-h' if-shell "$is_vim" 'send-keys c-h'  'select-pane -L'
      bind-key -n 'c-j' if-shell "$is_vim" 'send-keys c-j'  'select-pane -D'
      bind-key -n 'c-k' if-shell "$is_vim" 'send-keys c-k'  'select-pane -U'
      bind-key -n 'c-l' if-shell "$is_vim" 'send-keys c-l'  'select-pane -R'
    '';
  };
}
