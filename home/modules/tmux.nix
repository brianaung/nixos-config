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

			bind e send-prefix

			bind c new-window -c "#{pane_current_path}"
			bind = split-window -h -c "#{pane_current_path}"
			bind - split-window -v -c "#{pane_current_path}"

			bind -T copy-mode-vi v send-keys -X begin-selection
			bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'xclip -in -selection clipboard'
		'';
	};
}
