{ 
  config,
  ... 
}:

{
  users = {
    mutableUsers = false;
    users.${config.profile.userName} = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "adbuser"
        "uucp"
        "audio"
        "video"
        "kvm"
        "input"
        "seat"
      ];
      useDefaultShell = true;
      hashedPassword = "${config.profile.hashedPassword}";
    };
  };
}
