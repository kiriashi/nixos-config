{ config, pkgs, ... }:

{
  services.mihomo = {
    enable = true;
    package = pkgs.mihomo;
    webui = pkgs.zashboard;
    configFile = /home/kiriashi/.config/mihomo/config.yaml;
    extraOpts = ''
      --mode rule
      --ipv6 true
      --log-level info
      --allow-lan true
      --mixed-port 7890
      --unified-delay true
      --tcp-concurrent true
      --external-controller :9090

      --geodata-mode true
      --geodata-loader standard
      --geo-auto-update true
      --geo-update-interval 24
      --geox-url.geoip https://ghfast.top/https://github.com/MetaCubeX/meta-rules-dat/releases/download/latest/geoip.dat
      --geox-url.geosite https://ghfast.top/https://github.com/MetaCubeX/meta-rules-dat/releases/download/latest/geosite.dat
      --geox-url.mmdb https://ghfast.top/https://github.com/MetaCubeX/meta-rules-dat/releases/download/latest/country.mmdb
      --geox-url.asn https://ghfast.top/https://github.com/xishang0128/geoip/releases/download/latest/GeoLite2-ASN.mmdb

      --find-process-mode strict

      --keep-alive-interval 600
      --global-client-fingerprint random

      --profile.store-selected true
      --profile.store-fake-ip true

      --ntp.enable true
      --ntp.server time.apple.com
      --ntp.port 123
      --ntp.interval 30

      --sniffer.enable true
      --sniffer.sniff.HTTP.ports 80,8080-8880
      --sniffer.sniff.HTTP.override-destination true
      --sniffer.sniff.TLS.ports 443,8443
      --sniffer.sniff.QUIC.ports 443,8443
      --sniffer.skip-domain Mijia Cloud
      --sniffer.skip-domain +.push.apple.com

      --tun.enable true
      --tun.stack mixed
      --tun.dns-hijack any:53
      --tun.dns-hijack tcp://any:53
      --tun.auto-route true
      --tun.auto-redirect true
      --tun.auto-detect-interface true

      --dns.enable true
      --dns.listen :1053
      --dns.ipv6 true
      --dns.enhanced-mode fake-ip
      --dns.fake-ip-range 28.0.0.1/8
      --dns.fake-ip-filter *
      --dns.fake-ip-filter +.lan
      --dns.fake-ip-filter +.local
      --dns.default-nameserver 223.5.5.5
      --dns.default-nameserver 119.29.29.29
      --dns.default-nameserver [2402:4e00::]
      --dns.default-nameserver [2400:3200::1]
      --dns.nameserver tls://8.8.4.4
      --dns.nameserver tls://1.0.0.1
      --dns.nameserver tls://[2001:4860:4860::8844]
      --dns.nameserver tls://[2606:4700:4700::1001]
      --dns.proxy-server-nameserver https://doh.pub/dns-query
      --dns.nameserver-policy geosite:cn,private=https://doh.pub/dns-query,https://dns.alidns.com/dns-query
      --dns.nameserver-policy geosite:!cn,!private=tls://dns.google,tls://cloudflare-dns.com
    '';
  };
}