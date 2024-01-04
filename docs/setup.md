# Setup Instructions

## Setting up on NixOS
1. `sudoedit /etc/nixos/configuration.nix` then add these two lines:
```nix
# enable git (only if you are git cloning this repository)
programs.git.enable = true

# enable flakes
nix.settings.experimental-features = [ "nix-command" "flakes" ]
```

2. Rebuild the system with `sudo nixos-rebuild switch`.

3. Clone/download this repository to `~/.config/` directory.

4. Run `nix run home-manager/master -- switch --flake .#default` to activate the home user configurations.

5. **(Optional)** Adjust system configurations to your needs (such as configuring your desktop environment, window managers, etc.) by editing `~/.config/home-manager/system/nixos/configuration-extended.nix` before you run the make command.

6. Rebuild the system with this extended system configurations using `make system FLAKE=default`. 

7. Finally `sudo reboot`.

## Setting up on Non-NixOS
**WIP**

> Check the [faq](https://github.com/brianaung/home-manager/blob/main/docs/faqs.md), your issue may be covered =))
