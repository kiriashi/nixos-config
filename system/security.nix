{
  pkgs,
  config,
  ...
}:

{
  environment.systemPackages = with pkgs; [ doas-sudo-shim ];

  security = {
    rtkit.enable = true;
    apparmor.enable = true;

    doas = {
      enable = true;
      wheelNeedsPassword = true;
      extraRules = [
        {
          users = [ "${config.profile.userName}" ];
          noPass = false;
          keepEnv = false;
          persist = true;
        }
      ];
    };
  };

  programs.fish.shellAbbrs = {
    sudo = "doas";
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
