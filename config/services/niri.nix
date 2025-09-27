{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:
lib.mkIf config.optional.niri
{
  imports = [ inputs.niri-flake.nixosModules.niri ];
  nixpkgs.overlays = [ inputs.niri-flake.overlays.niri ];
  niri-flake.cache.enable = true;
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

    file-roller

    bibata-cursors
    adwaita-icon-theme
  ];

  programs = {
    xwayland.enable = true;
    niri = {
      enable = true;
      package = pkgs.niri-unstable;
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
