{ pkgs, ... }: {

  services.kanshi = {
    enable = true;
    systemdTarget = "hyprland-session.target";
    profiles = {
      undocked = {
        outputs = [
          {
            criteria = "eDP-1";
            mode = "2256x1504@60Hz";
            position = "0,0";
            scale = 1.6;
            status = "enable";
          }
        ];
      };
      home = {
        outputs = [
          { criteria = "eDP-1"; status = "disable"; }
          {
            criteria = "DP-4";
            mode = "1920x1080@144.00Hz";
            position = "0,0";
            scale = 1.0;
            status = "enable";
          }
        ];
      };
      work = {
        outputs = [
          { criteria = "eDP-1"; status = "disable"; }
          {
            criteria = "DP-1";
            mode = "2560x1440@59.951Hz";
            position = "0,0";
            scale = 1.0;
            status = "enable";
          }
        ];
      };
    };
  };
  home.packages = with pkgs; [ kanshi ];
}
