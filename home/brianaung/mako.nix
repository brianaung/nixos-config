{ ... }: {
  services.mako = {
    enable = true;
    settings = { default-timeout = 10000; };
  };
}
