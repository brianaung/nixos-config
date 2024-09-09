{ pkgs, ... }:
let
  hyprmonitor = pkgs.writeShellScriptBin "hyprmonitor" ''
    #!/bin/sh

    handle() {
      case $1 in
        monitoradded*)
          if [[ "$1" = "monitoradded>>DP-4" || "$1" = "monitoradded>>DP-1" ]]; then
            echo $1
            hyprctl keyword monitor eDP-1,disable
          fi
        ;;
        monitorremoved*)
          if [[ "$1" = "monitorremoved>>DP-4" || "$1" = "monitorremoved>>DP-1" ]]; then
            echo $1
            hyprctl keyword monitor eDP-1,highrr,0x0,1.566667
          fi
        ;;
      esac
    }

    socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done
  '';
in
{
  home.packages = [ hyprmonitor ];
}
