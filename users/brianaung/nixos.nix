{ pkgs, ... }:

{
	# we use zsh as our shell
	programs.zsh.enable = true;

	# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.brianaung = {
		isNormalUser = true;
		shell = pkgs.zsh;
		description = "Brian Aung";
		extraGroups = [ "networkmanager" "wheel" ];
		hashedPasswordFile = "/etc/passwordFile";
		# packages = with pkgs; [];
	};
}
