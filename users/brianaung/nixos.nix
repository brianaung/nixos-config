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

	services.postgresql = {
		enable = true;
		ensureDatabases = [ "mydatabase" ];
		enableTCPIP = true;
		# port = 5432;
		authentication = pkgs.lib.mkOverride 10 ''
			#type database DBuser origin-address auth-method
			local all       all                   trust
			# ipv4
			host  all      all     127.0.0.1/32   trust
			# ipv6
			host all       all     ::1/128        trust
		'';
		initialScript = pkgs.writeText "backend-initScript" ''
			CREATE USER nixcloud WITH LOGIN PASSWORD 'nixcloud' CREATEDB;
			CREATE DATABASE nixcloud;
			GRANT ALL PRIVILEGES ON DATABASE nixcloud TO nixcloud;
			GRANT ALL ON SCHEMA public TO nixcloud;
		'';
	};

	virtualisation.docker.enable = true;
}
