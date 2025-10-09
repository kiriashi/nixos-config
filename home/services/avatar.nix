{ config, pkgs, lib, ... }:

let
  username = config.profile.userName;
  homeDir  = config.profile.homeDir;
  avatarPath = "${homeDir}/.face";
  githubUrl = "https://github.com/${username}.png?size=256";
in {
  systemd.user.services.avatar = {
    Unit = {
      Description = "Fetch GitHub avatar for ${username}";
      After = [ "network-online.target" ];
      Wants = [ "network-online.target" ];
    };

    Service = {
      Type = "oneshot";
      ExecStart = pkgs.writeShellScript "fetch-github-avatar" ''
        set -euo pipefail
        AVATAR="${avatarPath}"
        URL="${githubUrl}"

        if [ -f "$AVATAR" ]; then
          echo "$AVATAR already exists, skipping."
          exit 0
        fi

        echo "Trying to download $URL ..."
        ${pkgs.curl}/bin/curl -fsL --max-time 30 "$URL" -o "$AVATAR" \
          && chmod 644 "$AVATAR" \
          && echo "Download success: $AVATAR" \
          || echo "Failed to fetch (Network error). Skipping."
      '';
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}