# Setup Instructions

## Setting up on NixOs
`cd /etc/nixos/` and `sudoedit configuration.nix`.

Then add these lines:
```nix
# enable git
programs.git.enable = true

# enable flakes
nix.settings.experimental-features = [ "nix-command" "flakes" ]

# enable i3 (not necessary if you will be rebuilding the system using my system config)
services.xserver = {
  enable = true;
  desktopManager.xterm.enable = false;
  displayManager.defaultSession = "none+i3";
  windowManager.i3.enable = true;
};
```

Rebuild the system with `sudo nixos-rebuild switch`.

Clone this repository to `~/.config/` directory.

Run `nix run home-manager/master -- switch --flake .#default` to .

(Optional) Rebuild the system using my system configuration files using `make system FLAKE=default`.

Finally `sudo reboot`.

## Setting up on Non-NixOs
wip
