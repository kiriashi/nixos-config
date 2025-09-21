{ config, pkgs, ... }:

let
  mihomoConfigPath = "$HOME/.config/mihomo/config.yaml";
  mihomoConfigUrl  = "https://sub.furina.ren/OfYj5LV9jRec9oKRwAOp/api/file/Mihomo";
in
{
  home.file.".config/mihomo/config.yaml".source = mihomoConfigPath;

  home.packages = [ pkgs.curl ];

  home.activation.mihomoUpdate = lib.hm.dag.entryAfter ["writeBoundary"] ''
    mkdir -p $(dirname ${mihomoConfigPath})
    curl -fsSL ${mihomoConfigUrl} -o ${mihomoConfigPath}.tmp || exit 0
    if ! cmp -s ${mihomoConfigPath}.tmp ${mihomoConfigPath}; then
      mv ${mihomoConfigPath}.tmp ${mihomoConfigPath}
      echo "Updated Mihomo config from remote."
      systemctl --user restart mihomo.service || true
    else
      rm ${mihomoConfigPath}.tmp
    fi
  '';

  systemd.user.timers.mihomo-update-timer = {
    description = "Daily Mihomo config update";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "daily";
      Persistent = true;
    };
    unitConfig = {
      ExecStart = "${pkgs.curl}/bin/curl -fsSL ${mihomoConfigUrl} -o ${mihomoConfigPath}.tmp && mv ${mihomoConfigPath}.tmp ${mihomoConfigPath} && systemctl --user restart mihomo.service";
    };
  };
}