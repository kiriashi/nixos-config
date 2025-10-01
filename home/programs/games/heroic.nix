{
  lib,
  config,
  username,
  pkgs,
  inputs,
  ...
}:

{
  home.packages = [ pkgs.heroic ];

  home.file = {
    proton-cachyos-heroic-link = {
      source = config.lib.file.mkOutOfStoreSymlink "${
        pkgs.proton-cachyos_x86_64_v4
      }/bin";
      target = "${config.xdg.configHome}/heroic/tools/proton/proton-cachyos";
    };
  };
}