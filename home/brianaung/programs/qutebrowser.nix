{ pkgs, ... }: {
  programs.qutebrowser = {
    enable = true;
    settings = {
      url = {
        default_page = "https://google.com";
        start_pages = "https://google.com";
      };
      auto_save.session = true;
    };
    keyBindings = {
      normal = {
        ",m" = "spawn umpv {url}";
        ",M" = "hint links spawn umpv {hint-url}";
        ";M" = "hint --rapid links spawn umpv {hint-url}";
      };
      command = {
        "<Ctrl-n>" = "completion-item-focus --history next";
        "<Ctrl-p>" = "completion-item-focus --history prev";
      };
      prompt = {
        "<Ctrl-n>" = "prompt-item-focus next";
        "<Ctrl-p>" = "prompt-item-focus prev";
      };
    };
    searchEngines = {
      DEFAULT = "https://google.com/search?hl=en&q={}";
    };
    greasemonkey = [
      (pkgs.writeText "skip-youtube-ads.js" ''
        // ==UserScript==
        // @name Skip YouTube ads
        // @description Skips the ads in YouTube videos
        // @run-at document-start
        // @include *.youtube.com/*
        // ==/UserScript==

        document.addEventListener('load', () => {
            const btn = document.querySelector('.videoAdUiSkipButton,.ytp-ad-skip-button-modern')
            if (btn) {
                btn.click()
            }
            const ad = [...document.querySelectorAll('.ad-showing')][0];
            if (ad) {
                document.querySelector('video').currentTime = 9999999999;
            }
        }, true);
      '')
    ];
  };

  home.packages = [
    pkgs.python312Packages.adblock
  ];
}
