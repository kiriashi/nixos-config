{
  ...
}:

{
  security = {
    rtkit.enable = true;
    apparmor.enable = true;
  };

  services.dbus.apparmor = "enabled";

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = true;
    };
  };

  networking.firewall = {
    allowedTCPPorts = [22 7897];
    allowedUDPPorts = [7897];
  
    allowedTCPPortRanges = [{ from = 1714; to = 1764; }];
    allowedUDPPortRanges = [{ from = 1714; to = 1764; }];
  };
}
