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

When trying to rebuild, it keeps saying that files I am trying to import are missing? I am sure they exists!
> Ensure you have staged all the files in git first before trying to rebuild.
