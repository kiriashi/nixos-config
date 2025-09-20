{ pkgs, lib, ... }:

let
  mihomoConfig = pkgs.fetchurl {
    url = "https://api.dler.io/sub?target=clash&url=https%3A%2F%2Fsub.furina.ren%2FOfYj5LV9jRec9oKRwAOp%2Fdownload%2Fcollection%2Fsingbox&insert=false&config=https%3A%2F%2Fraw.githubusercontent.com%2Fkiriashi%2Fstatic%2Frefs%2Fheads%2Fmain%2FACL4SSR_Online_Full_Mannix.ini&emoji=true&list=false&tfo=false&scv=true&fdn=false&expand=true&sort=false&udp=true&new_name=true";
  };
in
{
  services.mihomo = {
    enable = true;
    tunMode = true;
    package = pkgs.mihomo;
    webui = pkgs.zashboard;
    configFile = mihomoConfig;
    extraOpts = null;
  };
}