{ 
  ...
}:

{
  networking = {
    nftables.enable = true;

    networkmanager.enable = false;

    wireless = {
      enable = false;
      iwd.enable = true;
    };

    firewall = {
    enable = true;
    checkReversePath = "loose";
    # 常用端口
    allowedTCPPorts = [ 22 2080 80 443 ];
    allowedUDPPorts = [ 53 123 2080 ];
    # Kde Connect
    allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
    allowedUDPPortRanges = [ { from = 1714; to = 1764; } ];
    };
  };
}