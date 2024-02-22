{ pkgs, ... }:

{
	programs.tmux = {
		enable = true;
		package = pkgs.tmux;

		sensibleOnTop = false;
		terminal = "screen-256color";
		baseIndex = 1;
		escapeTime = 0;
		customPaneNavigationAndResize = true;

		prefix = "`";
		keyMode = "vi";
		mouse = false;

		extraConfig = ''
			set -sa terminal-features ",alacritty:RGB"
			set -g focus-events on

			set -g status-position top
			set -g status-style bg=default
			set -g status-left-length 90
			set -g status-right-length 90
			set -g status-justify centre

			bind e send-prefix

			bind c new-window -c "#{pane_current_path}"
			bind = split-window -h -c "#{pane_current_path}"
			bind - split-window -v -c "#{pane_current_path}"

			bind -T copy-mode-vi v send-keys -X begin-selection
			bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'xclip -in -selection clipboard'

			is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
					| grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?|fzf)(diff)?$'"
			bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
			bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
			bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
			bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'

			bind-key -T copy-mode-vi 'C-h' select-pane -L
			bind-key -T copy-mode-vi 'C-j' select-pane -D
			bind-key -T copy-mode-vi 'C-k' select-pane -U
			bind-key -T copy-mode-vi 'C-l' select-pane -R
		'';
	};
}
