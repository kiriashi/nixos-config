{
  pkgs,
  lib,
  config,
  ...
}:

{
  programs.niri.settings = {
    spawn-at-startup = [
      { argv = [ "fcitx5" "-d" ]; }
      { argv = [ "waypaper" "--restore" ]; }

      { sh = "wl-paste --watch cliphist store &"; }
    ];
    
    prefer-no-csd = true;

    hotkey-overlay = {
      skip-at-startup = true;
      hide-not-bound = true;
    };

    environment = {
      CLUTTER_BACKEND = "wayland";
      GDK_BACKEND = "wayland,x11";
      MOZ_ENABLE_WAYLAND = "1";
      NIXOS_OZONE_WL = "1";
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      ELECTRON_ENABLE_HARDWARE_ACCELERATION = "1";

      XDG_SESSION_TYPE = "wayland";
      XDG_CURRENT_DESKTOP = "niri";

      XMODIFIERS = "@im=fcitx";
      GLFW_IM_MODULE = "fcitx";
      QT_IM_MODULE = "fcitx";
      INPUT_METHOD = "fcitx";
    };

    xwayland-satellite  = {
      enable = true;
      path = lib.getExe pkgs.xwayland-satellite-unstable;
    };

    gestures.hot-corners.enable = false;

    screenshot-path = "~/Pictures/Screenshots/%Y-%m-%d_%H-%M-%S.png";

    input = {
      mouse = {
        enable = true;
        accel-speed = 0.6;
        accel-profile = "flat";
      };
      touchpad = {
        enable = true;
        tap = true;
        dwt = true;
        natural-scroll = true;
      };
    };

    outputs = {
      "eDP-1" = {
        scale = 2.0;
      };
      "HDMI-A-1" = {
        scale = 1.25;
        mode = {
          width = 2560;
          height = 1440;
          refresh = 144.002;
        };
      };
    };

    layout = {
      gaps = 6;

      center-focused-column = "on-overflow";
      always-center-single-column = true;

      preset-column-widths = [
        { proportion = 1. / 2.; }
        { proportion = 3. / 4.; }
        { proportion = 1.; }
      ];


      default-column-width = {
        proportion = 3. / 4.; 
      };

      focus-ring  = {
        enable = false;
        width = config.programs.niri.settings.layout.border.width;

        active = { 
          gradient = {
            from = "#a1c4fd";
            to = "#c2e9fb";
            angle=45;
          };
        };

        inactive = {
          color = "#505050";
        };
      };

      border = {
        enable = true;
        width = 3;
        
        active = { 
          gradient = {
            from = "#a1c4fd";
            to = "#c2e9fb";
            angle=45;
          };
        };

        inactive = {
          color = "#505050";
        };
      };
    
      shadow = {
        enable = true;
        softness = 4;
        spread = 0;
        offset = {
          x = 0;
          y = 0;
        };
        draw-behind-window = false;
        color = "#000000";
      };
    };

    switch-events = {
      lid-close.action.spawn = [ "niri msg action power-off-monitors" ];
      lid-open.action.spawn = [ "niri msg action power-on-monitors" ];
    };
  };

}