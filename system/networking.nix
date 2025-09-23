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

      allowedTCPPorts = [ 7890 9090 ];
      allowedUDPPorts = [ 7890 53 1053 ];

      allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
      allowedUDPPortRanges = [ { from = 1714; to = 1764; } ];
      
      checkReversePath = "loose";

      extraInputRules = ''
        iifname "Meta" accept
        iifname "lo" accept

        ip protocol icmp accept
        ip6 nexthdr icmpv6 accept
      '';
      extraForwardRules = ''
        iifname "Meta" accept
        oifname "Meta" accept
      '';
    };
  };
}