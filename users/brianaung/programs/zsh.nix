{ pkgs, ... }:

{
	programs.zsh = {
		enable = true;
		package = pkgs.zsh;

		enableAutosuggestions = true;
		enableCompletion = true;

		defaultKeymap = "viins";

		localVariables = {
			ZSH_AUTOSUGGEST_STRATEGY = [ "history" "completion" ];
		};

		shellAliases = {
				ls="${pkgs.eza}/bin/eza --classify";
				la="${pkgs.eza}/bin/eza --all --classify";
				ll="${pkgs.eza}/bin/eza --long --all --classify";
		};

		initExtra = ''
			bindkey '^y' autosuggest-accept
			bindkey -s ^f "tmux-sessionizer\n"
			source "$(${pkgs.fzf}/bin/fzf-share)/key-bindings.zsh"
			source "$(${pkgs.fzf}/bin/fzf-share)/completion.zsh"
		'';
	};
}
