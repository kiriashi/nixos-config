{ 
  config,
  ... 
}:

{
  users = {
    mutableUsers = false;
    users.${config.profile.userName} = {
      isNormalUser = true;
      description = config.profile.fullName;
      extraGroups = [
        "wheel"
        "networkmanager"
        "adbuser"
        "uucp"
        "audio"
        "video"
        "kvm"
        "input"
        "seat"
      ];
      useDefaultShell = true;
      hashedPassword = "${config.profile.userPasswd}";
    };
  };
}
