{ ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      qt6Packages = prev.qt6Packages.overrideScope (
        _final': prev': {
          # HACK：不再使用 qt5
          fcitx5-with-addons = prev'.fcitx5-with-addons.override { libsForQt5.fcitx5-qt = null; };

          # HACK：不再使用 KDE 相关内容
          fcitx5-configtool = prev'.fcitx5-configtool.override { kcmSupport = false; };

          # HACK：不再使用 qtwebengine、opencc
          fcitx5-chinese-addons =
            (prev'.fcitx5-chinese-addons.override {
              curl = null;
              opencc = null;
              qtwebengine = null;
            }).overrideAttrs
              (oldAttrs: {
                buildInputs = oldAttrs.buildInputs ++ [
                  prev.gettext
                  prev'.qtbase
                ];
                cmakeFlags = oldAttrs.cmakeFlags ++ [
                  (prev.lib.cmakeBool "ENABLE_BROWSER" false)
                  (prev.lib.cmakeBool "ENABLE_CLOUDPINYIN" false)
                  (prev.lib.cmakeBool "ENABLE_OPENCC" false)
                ];
              });
        }
      );

    # HACK：不再使用 gtk2
    gnome-themes-extra = (prev.gnome-themes-extra.override { gtk2 = null; }).overrideAttrs {
      configureFlags = [ "--disable-gtk2-engine" ];
    };

    # HACK:
    xdg-desktop-portal-gtk =
      (prev.xdg-desktop-portal-gtk.override {
        gnome-settings-daemon = null;
        gnome-desktop = null;
        gsettings-desktop-schemas = null;
      }).overrideAttrs
        { mesonFlags = [ (prev.lib.mesonEnable "wallpaper" false) ]; };

  (self: super: {
    scx_full = super.scx_full.overrideAttrs (old: {
      prePatch = (old.prePatch or "") + ''
        # 修复 bash 路径
        substituteInPlace meson-scripts/build_bpftool \
          --replace '/bin/bash' '${super.bash}/bin/bash'
        
        # 修复其他硬编码路径
        find . -type f -exec sed -i \
          -e 's|/bin/bash|${super.bash}/bin/bash|g' \
          -e 's|/usr/bin/env|${super.coreutils}/bin/env|g' \
          {} +
      '';
    });
  })
    })];
}
