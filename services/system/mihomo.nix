{ config, pkgs, ... }:
let
  mihomoConfig = pkgs.lib.makeHomeDirPath {
    user = config.profile.userName;
    path = ".config/mihomo/config.yaml";
  };
in
{
  services.mihomo = {
    enable = true;
    tunMode = true;
    package = pkgs.mihomo;
    webui = pkgs.zashboard;
    configFile = mihomoConfig;
  };
}