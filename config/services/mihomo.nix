{ config, pkgs, ... }:
let
  userHome = config.users.users.${config.profile.userName}.home;
  mihomoConfig = "${userHome}/.config/mihomo/config.yaml";
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