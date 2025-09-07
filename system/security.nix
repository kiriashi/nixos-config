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

  networking.firewall.allowedTCPPorts = [
    22
    7897
  ];

  networking.firewall.allowedUDPPorts = [
    7897
  ];
}
