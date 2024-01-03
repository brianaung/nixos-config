# Setup Instructions

## Setting up on NixOS
`cd /etc/nixos/` and `sudoedit configuration.nix`.

Then add these lines:
```nix
# enable git
programs.git.enable = true

# enable flakes
nix.settings.experimental-features = [ "nix-command" "flakes" ]
};
```

Rebuild the system with `sudo nixos-rebuild switch`.

Clone this repository to `~/.config/` directory.

Run `nix run home-manager/master -- switch --flake .#default` to activate the home configurations.

Rebuild the system with the extended system configuration using `make system FLAKE=default`.

Finally `sudo reboot`.

## Setting up on Non-NixOS
WIP

## Display settings
Use `xrandr` or `arandr` (gui) to configure the display settings as you wish.

Then save the currently configured config by running `autorandr -s <name>`. This will save the current display config to `~/.config/autorandr/<name>/`.

This config will now be automatically executed on startup.
