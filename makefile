switch:
	sudo nixos-rebuild switch --flake .

update:
	nix flake update

upgrade: update switch

fmt:
	nixfmt *

optimise:
	nix-store --optimise

clean:
	nix-collect-garbage -d && sudo nix-collect-garbage -d
