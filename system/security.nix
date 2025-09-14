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
    allowedTCPPorts = [22 2080];
    allowedUDPPorts = [2080];
  
    allowedTCPPortRanges = [{ from = 1714; to = 1764; }];
    allowedUDPPortRanges = [{ from = 1714; to = 1764; }];
  };
}
