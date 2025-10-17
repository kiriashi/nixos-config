{
  lib,
  ...
}:
final: prev: {
  qt6Packages = prev.qt6Packages.overrideScope (qt6Final: qt6Prev: {
    libsForQt5 = (qt6Prev.libsForQt5 or (prev.libsForQt5.overrideScope (_: _: {}))).overrideScope (qt5Final: qt5Prev: {
      fcitx5-qt = null;
    });
  });

  fcitx5-qt = final.qt6Packages.fcitx5-qt;

  fcitx5-configtool = prev.fcitx5-configtool.override { kcmSupport = false; };

  fcitx5-chinese-addons = prev.fcitx5-chinese-addons.override {
    enableCloudPinyin = false;
    enableOpencc = false;
    qtwebengine = null;
  };
}