{ 
  ... 
}:

{
  security = {
    rtkit.enable = true;
    apparmor.enable = true;
  };

  services.dbus.apparmor = "enabled";
  
  # networking.firewall = rec {
  #   allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
  #   allowedUDPPortRanges = allowedTCPPortRanges;
  # };
}
