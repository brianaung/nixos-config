# FAQs

## Chromium browsers fails to render webpages correctly. What is going on?
Close all the browsers and try deleting the GPU caches. 

An example for Brave browser:
```
rm -rf ~/.config/BraveSoftware/Brave-Browser/Default/GPUCache/
rm -rf ~/.config/chromium/Default/GPUCache/
```

## When trying to rebuild, it keeps saying that files I am trying to import are missing? I am sure they exists!
Ensure you have staged all the files in git first before trying to rebuild.

## How do I automatically manage display settings when only using a window manager?
Use `xrandr` (cli) or `arandr` (gui), to configure the display settings.

Then save the currently configured setup by running `autorandr -s <name>`, which will write to `~/.config/autorandr/<name>/`.

The config for current active hardware setup will be executed whenever you run `autorandr --change` (which is executed at startup in my i3 config).

## Some fonts are missing after installation?
Try running `fc-cache -r` to erase and rescan font information cache.

## How can I clean up old generations?
- `sudo nix-collect-garbage -d`: delete all *system* generations
- `nix-collect-garbage -d`: delete all *user* generations

## How do I partition, format, and mount a secondary drive?
Launch shell as root user > `sudo -i`.

### Partition
*(Example using fdisk)*

List the partition scheme > `fdisk -l`.
- `/dev/sdX` is the disk
- `/dev/sdXY` is the partition
> X: disk name, Y: partition number

Select the disk > `fdisk /dev/sdX`.

**Inside the fdisk command-line utility:**
- Delete the partition > `d <Y>`.
- Create new partition > `n` (you can simply just choose the default values for partition number, first sector, and last sector).
- View changes > `p`. 
- Write changes > `w`.

### Format
Example formatting to Ext4 filesystem > `mkfs.ext4 /dev/sdXY`.
