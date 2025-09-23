{ config, pkgs, ... }:
let
  mihomoConfig = pkgs.fetchurl {
    url = "https://sub.furina.ren/OfYj5LV9jRec9oKRwAOp/api/file/config.yaml";
    sha256 = "sha256-iFuc0IOcN4nZPSaNBaWHFN+RzHINpj9Dzmm/WrnxHRs=";
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