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
    allowedTCPPorts = [ 7890 9090 ];
    allowedUDPPorts = [ 7890 9090 ];
    # Kde Connect
    allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
    allowedUDPPortRanges = [ { from = 1714; to = 1764; } ];
    };
  };

  networking.firewall = {
  checkReversePath = "loose";
  extraInputRules = ''
    iifname "Meta" accept
  '';

  extraForwardRules = ''
    iifname "Meta" accept
    oifname "Meta" accept
  '';
  };
}