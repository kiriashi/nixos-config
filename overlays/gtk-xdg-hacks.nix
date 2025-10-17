{ lib, ... }:
final: prev: {
  gnome-themes-extra = prev.gnome-themes-extra.overrideAttrs (oldAttrs: {
    configureFlags = (oldAttrs.configureFlags or []) ++ [ "--disable-gtk2-engine" ];
  });
  xdg-desktop-portal-gtk = prev.xdg-desktop-portal-gtk.overrideAttrs (oldAttrs: {
    mesonFlags = (oldAttrs.mesonFlags or []) ++ [
      (lib.mesonEnable "wallpaper" false)
      "-Dsettings=disabled"
    ];
  });
}