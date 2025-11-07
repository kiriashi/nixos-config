{
  lib,
  config,
  pkgs,
  ...
}:

{
  home.file = {
    wine-links-proton-cachyos-bottles = {
      source = config.lib.file.mkOutOfStoreSymlink "${
        pkgs.proton-cachyos_x86_64_v4
      }/bin";
      target = "${config.xdg.dataHome}/bottles/runners/proton-cachyos_x86_64";
    };
  };

  home.packages = [
    (pkgs.bottles.override {
      removeWarningPopup = true;
    })
  ];

  # xdg.desktopEntries = {
  #   "bottles" = {
  #     name = "Bottles";
  #     comment = "Run Windows software";
  #     exec = "env PROTON_ENABLE_WAYLAND=1 PROTON_ENABLE_HDR=1 PROTON_USE_NTSYNC=1 PROTON_USE_WOW64=1 PULSE_SINK=Game bottles %u";
  #     terminal = false;
  #     icon = "com.usebottles.bottles";
  #     type = "Application";
  #     startupNotify = true;
  #     categories = [
  #       "Utility"
  #       "Game"
  #     ];
  #   };
  # };
}