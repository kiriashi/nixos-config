{ pkgs, lib, ... }:

{
  powerManagement.enable = true;

  services.smartd.enable = true;
  services.power-profiles-daemon.enable = false;
  services.auto-cpufreq.enable = true;

  # SCX 调频器
  services.scx = {
    enable = true;
    package = pkgs.scx.full;
    scheduler = "scx_rusty";
  };

  # 智能进程调度，游戏桌面优化
  services.ananicy = {
    enable = true;
    package = pkgs.ananicy-cpp;
    rulesProvider = pkgs.ananicy-rules-cachyos_git;
  };

  # 电源事件
  services.logind = {
    settings = {
      Login = {
        HandleLidSwitch = "suspend-then-hibernate";
        HandleLidSwitchExternalPower = "lock";
        HandleLidSwitchDocked = "ignore";
      
        HandlePowerKey = "lock";
        HandlePowerKeyLongPress = "poweroff";
      };
    };
  };

  systemd.sleep.extraConfig = ''
    HibernateDelaySec=15m
  '';
}

