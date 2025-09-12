{
  pkgs,
  lib,
  inputs,
  ...
}:

{
  imports = [ inputs.niri.nixosModules.niri ];

  nixpkgs.overlays = [ inputs.niri.overlays.niri ];

  environment.systemPackages = with pkgs; [
    pwvucontrol
    brightnessctl
    libnotify
    labwc

    swww
    mpvpaper
    waypaper
    socat

    xwayland-satellite-unstable

    # nemo-with-extensions
    nautilus
    file-roller
  ];

  programs = {
    xwayland.enable = true;
    niri = {
      enable = true;
      package = pkgs.niri-unstable;
      cache.enable = false;
    };
    gtklock.enable = true;
  };

  security.pam.services.gtklock.text = lib.readFile "${pkgs.gtklock}/etc/pam.d/gtklock";

  services = {
    xserver.desktopManager.runXdgAutostartIfNone = true;
    gvfs.enable = true;
    seatd.enable = true;
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
