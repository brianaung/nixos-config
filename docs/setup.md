# Setup Instructions

## Setting up on NixOS
`cd /etc/nixos/` and `sudoedit configuration.nix`.

Then add these lines:
```nix
# enable git
programs.git.enable = true

# enable flakes
nix.settings.experimental-features = [ "nix-command" "flakes" ]
```

Rebuild the system with `sudo nixos-rebuild switch`.

Clone this repository to `~/.config/` directory.

Run `nix run home-manager/master -- switch --flake .#default` to activate the home configurations.

Rebuild the system with the extended system configuration using `make system FLAKE=default`. To adjust the configurations to your needs, edit ~/.config/home-manager/system/nixos/configuration-extended.nix` before you run the make command.

Finally `sudo reboot`.

## Setting up on Non-NixOS
WIP
