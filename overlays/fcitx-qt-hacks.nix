{ lib, ... }:
final: prev: {
  gnome-themes-extra = (prev.gnome-themes-extra.override { gtk2 = null; }).overrideAttrs {
    configureFlags = [ "--disable-gtk2-engine" ];
  };

  xdg-desktop-portal-gtk =
    (prev.xdg-desktop-portal-gtk.override {
      gnome-settings-daemon = null;
      gnome-desktop = null;
      gsettings-desktop-schemas = null;
    }).overrideAttrs
      { mesonFlags = [ (lib.mesonEnable "wallpaper" false) ]; };
}
