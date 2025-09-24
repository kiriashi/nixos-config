{ 
  pkgs,
  ...
}:

{ 
  environment.systemPackages = with pkgs; [
    connman-gtk
    ];

  services.connman = {
    enable = true;
    enableVPN = true;
    wifi.backend = "iwd";
    extraConfig = "
      [General]
      AllowHostnameUpdates=false
    ";
  };

  networking = {
    hostName = "RBP15-2022";

    nameservers = [ "119.29.29.29" "8.8.8.8" ];
    
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
      allowedUDPPorts = [ 7890 53 123 ];

      allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
      allowedUDPPortRanges = [ { from = 1714; to = 1764; } ];
      
      checkReversePath = "loose";

      trustedInterfaces = [ "Meta" ];

      extraInputRules = ''
        ip6 nexthdr ipv6-icmp accept
      '';
    };
  };
}