{
  pkgs,
  lib,
  ...
}:
{

  environment.systemPackages = [
    pkgs.sparkle
  ];

  security.wrappers.clash-verge = {
    owner = "root";
    group = "root";
    capabilities = "cap_net_bind_service,cap_net_raw,cap_net_admin=+ep";
    source = lib.getExe pkgs.sparkle;
  };

}
