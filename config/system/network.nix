{ 
  ...
}:

{ 
  networking = {
    hostName = "RBP152022";
    
    networkmanager.enable = false;

    wireless = {
      enable = false;
      iwd.enable = true;
    };

    nftables = {
      enable = true;
    };

    firewall = {
      enable = true;

      allowedTCPPorts = [ 7890 9090 ];
      allowedUDPPorts = [ 7890 53 1053 ];

      allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
      allowedUDPPortRanges = [ { from = 1714; to = 1764; } ];
      
      checkReversePath = "loose";
      
      trustedInterfaces = [ "Meta" ];

      extraCommands = ''
        ip6tables -A nixos-fw -p ipv6-icmp -j ACCEPT
      '';
      networking.firewall.extraStopCommands = ''
        ip6tables -D nixos-fw -p ipv6-icmp -j ACCEPT || true
      '';
    };
  };
}