system:
	sudo nixos-rebuild switch --flake .#$(FLAKE) --impure

home:
	home-manager switch --flake .#$(FLAKE)

.PHONY: system home
