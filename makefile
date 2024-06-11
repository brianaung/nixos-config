switch:
	sudo nixos-rebuild switch --flake .

test:
	sudo nixos-rebuild test --flake . --show-trace

update:
	nix flake update

upgrade: update switch

optimise:
	nix-store --optimise

clean:
	nix-collect-garbage -d && sudo nix-collect-garbage -d
