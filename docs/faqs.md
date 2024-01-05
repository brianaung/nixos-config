# FAQs

## During minimal nix install, how do I connect to WiFi?
Connect to internet by running: `nmcli device wifi connect <SSID> password <password>`.

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
