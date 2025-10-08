{ lib, ... }:
final: prev: {
  qt6Packages = prev.qt6Packages.overrideScope (
    _final': prev': {
      fcitx5-with-addons = prev'.fcitx5-with-addons.override { libsForQt5.fcitx5-qt = null; };
      fcitx5-configtool = prev'.fcitx5-configtool.override { kcmSupport = false; };
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
              (lib.cmakeBool "ENABLE_BROWSER" false)
              (lib.cmakeBool "ENABLE_CLOUDPINYIN" false)
              (lib.cmakeBool "ENABLE_OPENCC" false)
            ];
          });
    }
  );
}
