# common issues

During minimal nix install, how do I connect to WiFi?
> Connect to internet by running: `nmcli device wifi connect <SSID> password <password>`.

Chromium browsers fails to render webpages correctly. What is going on?
> Close all the browsers and try deleting the GPU caches.
    Example, for Brave browser:
    ```
    rm -rf ~/.config/BraveSoftware/Brave-Browser/Default/GPUCache/
    rm -rf ~/.config/chromium/Default/GPUCache/
    ```
