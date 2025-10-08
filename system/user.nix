  lib,
  pkgs,
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
  services.accounts-daemon.enable = true;
  system.activationScripts.githubAvatar = lib.stringAfter [ "users" ] ''
    AVATAR_FILE="${config.profile.homeDir}/.face"
    if [ ! -f "$AVATAR_FILE" ]; then
      echo "Fetching GitHub avatar for ${config.profile.userName}..."
      ${pkgs.curl}/bin/curl -fsSL "https://github.com/${config.profile.userName}
      chown ${config.profile.userName}:${config.profile.userName} "$AVATAR_FILE"
      chmod 644 "$AVATAR_FILE"
    else
      echo "Avatar already exists, skipping."
    fi
  '';
}