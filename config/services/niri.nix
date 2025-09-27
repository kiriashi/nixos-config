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
      package = pkgs.wayland-satellite-unstable;
    };
    nautilus-open-any-terminal = {
      enable = true;
      terminal = "kitty";
    };
    gtklock.enable = true;
  };

  security.pam.services.gtklock.text = lib.readFile "${pkgs.gtklock}/etc/pam.d/gtklock";

  services = {
    xserver.desktopManager.runXdgAutostartIfNone = true;
    gvfs.enable = true;
    seatd.enable = true;
    gnome.sushi.enable =true;
    gnome.gnome-keyring.enable = lib.mkForce false;
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
