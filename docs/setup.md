# Setup Instructions

## NixOS Minimal Installer Guide

### Connect to internet
See [how](https://nixos.wiki/wiki/NixOS_Installation_Guide#Connecting_to_the_internet).

> A more detailed [guide](https://www.linuxbabe.com/command-line/ubuntu-server-16-04-wifi-wpa-supplicant) on how to connect to network using `wpa_supplicant`.

### Bootstraping
Lauch shell as root user > `sudo -i`.

Partition and format disks, then install the OS.
- Get the makefile > `curl -O https://raw.githubusercontent.com/brianaung/home-manager/main/makefile`.
- Enter shell environment with make installed > `nix-shell -p gnumake`.
- **(Optional)** Check the content of the makefile and make changes to partitioning and formatting process as you prefer.
- Then run > `make bootstrap`.
- Login again as `username: root` and `password: root`. 

> If you are using wireless connection, you may have to reconnect to your network again. Since I have enable network manager as part of the bootstrap, you can now simply run: `nmcli device wifi connect <SSID> password <password>` to connect to your network.

### Download configs
Curl and extract config repository.
```
curl -LJO https://github.com/brianaung/home-manager/archive/refs/heads/main.tar.gz && \
tar -zxf home-manager-main.tar.gz
```

### For new machines (skip to [rebuilding](#rebuilding) if you are setting up on old machine)
Copy the generated system config files.
```
cd home-manager-main && \
cp /etc/nixos/configuration.nix machines/<NIXNAME>.nix && \
cp /etc/nixos/hardware-configuration.nix machines/hardwares/<NIXNAME>.nix
```

Update `./machines/<NIXNAME>.nix`.
- Update path to point to correct hardware configuration.
- Add path to shared config.
- Remove any duplicate or conflicting expressions (those that already exists in shared config). For example, you can remove these lines that are added during bootstrapping:
    ```
    system.stateVersion = "23.11";
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nixpkgs.config.allowUnfree = true;
	networking.networkmanager.enable = true;
    environment.systemPackages = with pkgs; [
        vim
    ];
    nixpkgs.config.permittedInsecurePackages = [ "electron-25.9.0" ];
    ```

> DO NOT remove the line `users.users.root.initialPassword = "root";` until you have completed all the steps and have ensured that you are able to log into your user account with the password you have set. Only then, you should remove it so that you won't get locked out if there were any issues.

Update `flake.nix`.
```nix
<NIXNAME> = mkSystem "<NIXNAME>" {
    system = "<ARCHITECTURE>";
    user = "<USER>"; # check `users/<USER>/nixos.nix` file to update user account details
};
```

### Rebuilding
***(IMPORTANT)*** Generate hashed password > `mkpasswd -m sha-512 <your_password> > /etc/passwordFile`

Rebuild the system > `nixos-rebuild switch --flake .#<NIXNAME>`.

Finally, `reboot`.

> When rebooting into current user account after the [rebuilding](#rebuilding) step, you may want to copy the new system configurations from the root user directory to current user directory. After copying the configs (e.g. `sudo -i` and then `cp -r ~/home-manager-main /home/<USER>/.config/home-manager`), you will need to change the ownership of the directory and its contents using `sudo chown -R <USER> home-manager`.

Finally, check out the [faqs](https://github.com/brianaung/home-manager/blob/main/docs/faqs.md), some of your issues may be covered =)).
