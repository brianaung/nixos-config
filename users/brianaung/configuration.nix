{ pkgs, ... }:

{
	# we use zsh as our shell
	programs.zsh.enable = true;

	users.users.brianaung = {
		isNormalUser = true;
		shell = pkgs.zsh;
		description = "Brian Aung";
		extraGroups = [ "networkmanager" "wheel" "docker"];
		hashedPasswordFile = "/etc/passwordFile";
	};
}
