# home-manager

These are my configuration files. Feel free to take anything you think is cool, though I don't claim to be an expert (especially in Nix) so copy at your own risk.

Always a WIP :)

## Setting up on NixOs
`cd /etc/nixos/` and `sudoedit configuration.nix`.

Then add these lines:
```nix
# enable git
programs.git.enable = true

# enable flakes
nix.settings.experimental-features = [ "nix-command" "flakes" ]

# enable i3
services.xserver = {
  enable = true;
  desktopManager.xterm.enable = false;
  displayManager.defaultSession = "none+i3";
  windowManager.i3.enable = true;
};

# enable zsh
programs.zsh.enable = true;
users.users.<username>.shell = pkgs.zsh;

# allow running of non-nix executables
programs.nix-ld.enable = true;
```

Rebuild the system with `sudo nixos-rebuild switch`.

Clone this repository to `~/.config/` directory.

Run `nix run home-manager/master -- switch --flake .#default` to .

Finally `sudo reboot`.

## Setting up on Non-NixOs
wip
