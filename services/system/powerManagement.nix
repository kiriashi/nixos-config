{ pkgs, lib, ... }:

{
  powerManagement.enable = true;

  # 硬盘健康监控
  services.smartd.enable = true;

  # 自动 CPU 调频
  services.auto-cpufreq.enable = true;

  # 智能进程调度，游戏桌面优化
  services.ananicy = {
    enable = true;
    package = pkgs.ananicy-cpp;
    rulesProvider = pkgs.ananicy-rules-cachyos_git;
  };

  # 休眠设置
  boot.resumeDevice = "/dev/disk/by-uuid/afcab6ad-1992-4b90-90de-8e92375efb12";

  services.logind = {
    settings = {
      Login = {
        HandleLidSwitch = "suspend-then-hibernate";
        HandleLidSwitchExternalPower = "lock";
        HandleLidSwitchDocked = "ignore";
      
        HandlePowerKey = "hibernate";
        HandlePowerKeyLongPress = "poweroff";
      };
    };
  };

  
  # systemd.sleep.extraConfig = ''
  #   HibernateDelaySec=15m
  #   SuspendThenHibernateDelaySec=15m
  # '';
}

