{ config, ... }: {
  services.swaync = {
    enable = true;
    settings = {
      positionX = "right";
      positionY = "top";
      layer = "overlay";
      control-center-layer = "top";
      layer-shell = true;
      cssPriority = "application";
      control-center-margin-top = 5;
      # control-center-margin-bottom = 5;
      control-center-margin-right = 5;
      control-center-margin-left = 5;
      control-center-height = 700;
      fit-to-screen = false;
      notification-2fa-action = true;
      notification-inline-replies = false;
      notification-icon-size = 64;
      notification-body-image-height = 100;
      notification-body-image-width = 200;
    };
    style = ''
      * {
        font-family: Fira sans;
        font-weight: normal;
        color: #${config.colors.White};
      }
      .control-center {
        background: #${config.colors.Black};
        color: #${config.colors.White};
      }
      .notification {
        border-radius: 5px;
      }
      .notification-content {
        background: #${config.colors.Black};
        border-radius: 5px;
        padding: 10px;
      }
      .widget-title>button {
        border-radius: 5px;
        background: #${config.colors.Black};
      }
      .widget-dnd>switch {
        padding: 2px;
        border-radius: 5px;
        background: #${config.colors.Black};
      }
      .widget-dnd>switch:checked {
        background: #${config.colors.Blue};
      }
      .widget-dnd>switch slider {
        background: #${config.colors.White};
      }
    '';
  };
}
