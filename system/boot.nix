{
  config,
  pkgs,
  ...
}:

{
  boot = {
    enableContainers = false;

    kernelPackages = pkgs.linuxPackages_cachyos-lto;

    resumeDevice = "/dev/disk/by-uuid/ebfe7aad-5067-4435-ba3e-c34d40ce6830";

    kernel.sysctl = {
      "vm.max_map_count" = 262144000;
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
