# NixOS Minimal Installer Guide

## Installation Summary
### Setup network
wip (not necessary in vm)

### Bootstraping
Lauch shell as root user > `sudo -i`.

Partition and format disks, then install the OS.
- Get the makefile > `curl -O https://raw.githubusercontent.com/brianaung/home-manager/main/makefile`.
- Enter shell environment with make installed > `nix-shell -p gnumake`.
- **(Optional)** Check the content of the makefile to make changes to partitioning and formatting process.
- Then run > `make bootstrap`.
- Login again as `username: root` and `password: root`. 

### Download configs
Curl and extract config repository.
```
curl -LJO https://github.com/brianaung/home-manager/archive/refs/heads/main.tar.gz; && \
tar -zxf home-manager-main.tar.gz
```

### For new machines (skip to [rebuilding](#rebuilding) if you are setting up on old machine)
Copy the generated system config files.
```
cp /etc/nixos/configuration.nix machines/<NIXNAME>.nix && \
cp /etc/nixos/hardware-configuration.nix machines/hardwares/<NIXNAME>.nix
```

Update `./machines/<NIXNAME>.nix`.
- update path to point to correct hardware configuration.
- add path to shared config.
- optionally remove duplicate expressions (those that already exists in shared config), although they shouldn't cause any issues.
    ```
    system.stateVersion = "23.11";
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nixpkgs.config.allowUnfree = true;
    nixpkgs.config.permittedInsecurePackages = [ "electron-25.9.0" ];
	users.users.root.initialPassword = \"root\";
    ```

Update `flake.nix`.
```nix
<NIXNAME> = mkSystem "<NIXNAME>" {
    system = "<ARCHITECTURE>";
    user = "<USER>"; # check `users/<USER>/nixos.nix` file to update user account details
};
```

> When rebooting into current user account after the [rebuilding](#rebuilding) step, you may want to copy the new system configurations from the root user directory to current user directory. After copying the configs (e.g. `sudo -i` and `cp -r ~/.config/home-manager /home/<USER>/.config/home-manager`), you will need to change the ownership of the directory and its contents using `sudo chown -R <USER> home-manager`.

### Rebuilding
Rebuild the system > `nixos-rebuild switch --flake .#<NIXNAME>`.

***(IMPORTANT)*** Generate hashed password > `mkpasswd -m sha-512 <your_password> > /etc/passwordFile`

Finally, `reboot`.
