{
  lib,
  pkgs,
  ...
}:

{
  services = {
    pipewire = lib.mkForce {
      enable = true;
      pulse.enable = true;
      jack.enable = true;
      alsa.support32Bit = true;
      wireplumber.enable = true;
    };
    pulseaudio.enable = false;

    fstrim = {
      enable = true;
      interval = "weekly";
    };

    scx = {
      enable = true;
      package = pkgs.scx_git.full.overrideAttrs (old: {
      # 禁用有问题的 bpftool 构建
      mesonFlags = (old.mesonFlags or []) ++ [
        "-Dbpftool=disabled"
      ];
      
      # 添加必要的构建依赖
      nativeBuildInputs = (old.nativeBuildInputs or []) ++ [
        pkgs.bpftool  # 提供系统级 bpftool
        pkgs.gnused   # 用于脚本修复
      ];
      
      # 创建必要的环境
      preConfigure = (old.preConfigure or "") + ''
        # 创建虚拟 /bin 目录
        mkdir -p bin
        ln -sf ${pkgs.bash}/bin/bash bin/bash
        ln -sf ${pkgs.bash}/bin/sh bin/sh
        export PATH="$PWD/bin:$PATH"
        
        # 修复所有脚本
        patchShebangs .
      '';
    });
      scheduler = "scx_rusty";
    };

    xserver = {
      excludePackages = [ pkgs.xterm ];
      upscaleDefaultCursor = true;
    };
    
    flatpak.enable = true;

    usbguard.dbus.enable = true;
    udisks2.enable = true;
    upower.enable = true;

    envfs.enable = true;
    
    speechd.enable = lib.mkForce false;
  };
}
