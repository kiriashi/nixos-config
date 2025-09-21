{ config, pkgs, ... }:

let
  configPath = "${config.home.homeDirectory}/.config/mihomo/config.yaml";
  
  updateScript = pkgs.writeShellScriptBin "update-mihomo-config" ''
    #!/bin/sh
    curl -sL "https://sub.furina.ren/OfYj5LV9jRec9oKRwAOp/api/file/Mihomo" -o ${configPath}.tmp
    if ${pkgs.mihomo}/bin/mihomo check -d ${configPath}.tmp; then
      mv ${configPath}.tmp ${configPath}
      systemctl --user restart mihomo.service
      echo "✅ 配置更新成功"
    else
      rm -f ${configPath}.tmp
      echo "❌ 配置无效，保留旧配置"
    fi
  '';
in
{
  # 确保配置目录存在
  home.file.".config/mihomo".source = pkgs.runCommand "mihomo-dir" {} "mkdir -p $out";

  # 自动更新服务
  systemd.user = {
    services.update-mihomo-config = {
      Unit.Description = "更新 Mihomo 配置";
      Service = {
        Type = "oneshot";
        ExecStart = "${updateScript}/bin/update-mihomo-config";
      };
    };
    
    timers.update-mihomo-config = {
      Unit.Description = "每6小时更新 Mihomo 配置";
      Timer = {
        OnCalendar = "*-*-* 0/6:00:00";
        Persistent = true;
      };
      Install.WantedBy = ["timers.target"];
    };
  };
}