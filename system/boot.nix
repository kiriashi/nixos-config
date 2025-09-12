{
  config,
  pkgs,
  ...
}:

{
  boot = {
    enableContainers = false;

    kernelPackages = pkgs.linuxPackages_cachyos-lto;
    
    kernel.sysctl = {
      "vm.max_map_count" = 2147483642;
    };

    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
      efi = {
        efiSysMountPoint = "/boot";
        canTouchEfiVariables = true;
      };
    };

    tmp = {
      useTmpfs = true;
      cleanOnBoot = true;
    };

    # v412虚拟摄像头
    extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];
    extraModprobeConfig = ''
      options v4l2loopback devices=1 video_nr=2 exclusive_caps=1 card_label="OBS Virtual Camera"
    '';
  };
}
