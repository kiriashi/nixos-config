{ 
  pkgs,
  config,
  ...
}:

{ 
  environment.systemPackages = with pkgs; [
    dig
    nmgui
  ];

  networking = {
    hostName = config.profile.hostName;

    networkmanager = {
      enable = true;
      wifi = {
        macAddress = "random";
        backend = "iwd";
      };
      # dns = "none";
    };

    nameservers =
      if (config.networking.networkmanager.dns == "none") then
        [ "127.0.0.1:53" ]
      else
        [
          "119.29.29.29"
          "8.8.8.8"
        ];

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

  # DNS 服务器
  services.resolved.enable = false;
  services.smartdns = {
    enable = false;
    settings = {
      # Basic
      bind = "[::]:53";
      # Upstream
      server = [
        "211.138.245.180 -group domestic -exclude-default-group"
      ];
      server-tls = [
        "223.5.5.5 -b -group domestic -exclude-default-group"
        "223.6.6.6 -group domestic -exclude-default-group"
        "one.one.one.one -proxy mihomo"
        "dns.google -proxy mihomo"
      ];
      server-https = [
        "https://dns.google/dns-query -proxy mihomo"
        "https://doh.pub/dns-query -group domestic"
      ];
      # Cache
      serve-expired = true;
      serve-expired-ttl = 259200;
      serve-expired-reply-ttl = 3;
      prefetch-domain = true;
      serve-expired-prefetch-time = 21600;
      cache-size = 32768;
      cache-checkpoint-time = 86400;
      # Dual stack (v4/v6)
      dualstack-ip-selection = "yes";
      # Speedtest
      speed-check-mode = "none";
      # Proxy (assuming that mihomo listen socks5 at port 7890)
      proxy-server = "socks5://127.0.0.1:7890 -name mihomo";
      # Other config
      conf-file = [
        # Ref: https://blog.skk.moe/post/i-have-my-unique-dns-setup#%E5%9C%A8-SmartDNS-%E4%B8%AD%E4%BD%BF%E7%94%A8-dnsmasq-china-list-%E8%BF%9B%E8%A1%8C%E5%88%86%E6%B5%81
        (toString /path/to/dnsmasq-china-list/accelerated-domains.china.domain.smartdns.conf)
        (toString /path/to/dnsmasq-china-list/apple.china.domain.smartdns.conf)
      ];
    };
  };
}