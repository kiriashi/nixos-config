{
  lib,
  pkgs,
  config,
  ...
}:
lib.mkIf config.optional.niri
{
  programs = {
    niri = {
      enable = true;
      package = pkgs.niri-unstable;
    };    
    xwayland = {
      enable = true;
      package = pkgs.xwayland-satellite-unstable;
    };
    gtklock = {
      enable = true;
      config = {
        main = {
          idle-hide = true;
          idle-timeout = 60;
          time-format = "%H:%M:%S";
        };
        userinfo = {
          image-size = 128;
          under-clock = true;
        };
      };
      modules = with pkgs; [
        gtklock-userinfo-module
        gtklock-powerbar-module
        gtklock-playerctl-module
      ];
    };
  };

  security.pam.services.gtklock.text = lib.readFile "${pkgs.gtklock}/etc/pam.d/gtklock";

  services = {
  xserver.desktopManager.runXdgAutostartIfNone = true;
    gvfs.enable = true;
    seatd.enable = true;
  };

  xdg = {
    portal = {
      enable = true;
      config = {
        niri = {
          default = [ "gnome" ];
          "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
        };
      };
      extraPortals = [
        pkgs.xdg-desktop-portal-gnome
        pkgs.xdg-desktop-portal-gtk
      ];
    };
    terminal-exec = {
      enable = true;
      settings = {
        default = [
          "kitty.desktop"
        ];
      };
    };
    autostart.enable = true;
  };
}
