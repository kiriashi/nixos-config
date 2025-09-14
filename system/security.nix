{
  ...
}:

{
  security = {
    rtkit.enable = true;
    apparmor.enable = true;
  };

  services = {
    dbus.apparmor = "enabled";

    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = true;
      };
    };
  };
}
