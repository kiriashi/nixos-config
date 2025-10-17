{ 
  pkgs,
  config,
  ...
}:

{ 
  environment.systemPackages = with pkgs; [
    iw
    dig
    nmgui
    ethtool
    macchanger
  ];

  networking = {
    hostName = config.profile.hostName;

    wireless = {
      enable = false;
      iwd.enable = true;
    };

    networkmanager = {
      enable = true;
      wifi = {
        powersave = true;
        macAddress = "random"; # or "permanent"
        backend = "iwd";
      };
      dns = "default";  # "default" | "none" | "systemd-resolved"
    };

    nameservers =
      if (config.networking.networkmanager.dns == "none") then
        [ "127.0.0.1:53" ]
      else
        [
          "119.29.29.29"
          "8.8.8.8"
        ];

    nftables = {
      enable = true;
    };

    firewall = {
      enable = true;

      allowedTCPPorts = [ 7890 9090 ];
      allowedUDPPorts = [ 53 7890 ];

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