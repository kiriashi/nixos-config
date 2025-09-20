{ pkgs, lib, ... }:

{
  powerManagement.enable = true;

  # 硬盘健康监控
  services.smartd.enable = true;

  # 自动 CPU 调度
  services.auto-cpufreq.enable = true;

  # SCX 调频器
  services.scx = {
    enable = true;
    package = pkgs.scx_git.rustscheds;
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
      
        HandlePowerKey = "hibernate";
        HandlePowerKeyLongPress = "poweroff";
      };
    };
  };
}

