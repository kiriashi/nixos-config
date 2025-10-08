{ config, lib, pkgs, ... }:

let
  userName = config.profile.userName;
  homeDir = config.profile.homeDir;
  avatarFile = "${homeDir}/.face";
  shouldEnableAvatarService = userName != null && userName != "";
in
{
  systemd.services.github-avatar-fetch = lib.mkIf shouldEnableAvatarService {
    description = "Fetch GitHub Avatar for ${userName}";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    # 仅运行一次
    serviceConfig = {
      Type = "oneshot";
      User = userName;
      WorkingDirectory = homeDir;
      Environment = [ "PATH=${lib.makeBinPath [ pkgs.curl ]}" ];
      ExecStart = ''
        AVATAR_FILE="${avatarFile}"
        if [ ! -f "$AVATAR_FILE" ]; then
          echo "Fetching GitHub avatar for ${userName}..."
          ${pkgs.curl}/bin/curl -fsSL "https://github.com/${userName}.png?size=256" -o "$AVATAR_FILE"
          if [ $? -eq 0 ]; then
            chmod 644 "$AVATAR_FILE"
          else
            echo "Failed to fetch avatar."
          fi
        else
          echo "Avatar already exists, skipping."
        fi
      '';
    };
  };

  systemd.timers.github-avatar-fetch = lib.mkIf shouldEnableAvatarService {
    description = "Wait for network and run github-avatar-fetch";
    wantedBy = [ "multi-user.target" ];
    timerConfig = {
      OnBootSec = "30s";
      Unit = "github-avatar-fetch.service";
      ConditionFileNotEmpty = "!${avatarFile}";
    };
  };
}
