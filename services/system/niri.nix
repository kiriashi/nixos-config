{
  pkgs,
  lib,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    pwvucontrol
    brightnessctl
    libnotify
    labwc

    swww
    mpvpaper
    waypaper
    socat

    xwayland-satellite

    # nemo-with-extensions
    nautilus
    file-roller
  ];

  programs = {
    xwayland.enable = true;
    niri = {
      enable = true;
      cache.enable = true;
      package = pkgs.niri;
    };
    gtklock.enable = true;
  };

  services.gnome.gnome-keyring.enable = lib.mkForce false;
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
