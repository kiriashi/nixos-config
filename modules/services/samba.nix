{
  config,
  ...
}:
{
  services.samba = {
    enable = false;
    openFirewall = true;
    usershares = {
      enable = true;
      group = "samba";
    };
    settings = {
      global = {
        workgroup = "WORKGROUP";
        security = "user";
        "map to guest" = "bad user";
        "server string" = "NixOS Samba Server";
        "server min protocol" = "SMB3";
      };
      "kiriashi" = {
        path = config.profile.homeDir;
        comment = "Main User Home Directory";
        browseable = "yes";
        "read only" = "no";
        "valid users" = config.profile.userName;
        "create mask" = "0644";
        "directory mask" = "0755";
      };
    };
  };
  users.users.${config.profile.userName}.extraGroups = [ "samba" ];
}