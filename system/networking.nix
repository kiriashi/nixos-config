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
    enable = false;
    # 放行端口
    allowedTCPPorts = [ 7891 9090 ];
    allowedUDPPorts = [ 7891 9090 ];
    # Kde Connect
    allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
    allowedUDPPortRanges = [ { from = 1714; to = 1764; } ];
    };
  };

  networking.firewall = {
  checkReversePath = "loose";
  extraInputRules = ''
    iifname "Mihomo" accept
  '';

  extraForwardRules = ''
    iifname "Mihomo" accept
    oifname "Mihomo" accept
  '';
  };
}