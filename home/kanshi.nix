{ ... }: {
  services.kanshi = {
    enable = true;
    profiles = {
      undocked = {
        outputs = [
          {
            criteria = "eDP-1";
            mode = "2256x1504@59.999Hz";
            position = "0,0";
          }
        ];
      };
    };
  };
}
