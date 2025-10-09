{ config, pkgs, ... }:
let
  mihomoConfig = "${config.profile.homeDir}/.config/mihomo/mihomo.yaml";
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