system:
	sudo nixos-rebuild switch --flake .#$(FLAKE)

home:
	home-manager switch --flake .#$(FLAKE)

.PHONY: system home
