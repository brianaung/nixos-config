{ lib, pkgs, ... }:

{
	programs.starship = {
		enable = true;
		package = pkgs.starship;
		settings = {
			command_timeout = 2000;
			add_newline = false;
			format = lib.concatStrings [
				"$directory"
				"$git_branch"
				"$git_status"
				"$nix_shell"
				"$character"
			];

			character = {
				success_symbol = "[λ>](bold cyan)";
				error_symbol = "[λ>](bold red)";
				vimcmd_symbol = "[λ|](bold cyan)";
			};

			directory = {
				format = ''([[\[](bold white)$path[\]](bold white)](bold cyan) )'';
				truncation_length = 1;
			};

			git_branch = {
				format = "[$branch ](bold purple)";
			};

			git_status = {
				format = ''([\[$all_status$ahead_behind\]](bold red) )'';
			};

			nix_shell = {
				format = "[$symbol$state ](bold blue)";
			};
		};
	};
}
