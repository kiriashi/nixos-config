{ pkgs, ... }:
{
  # ===== AMD 内核模块 =====
  boot.extraModprobeConfig = ''
    options kvm_amd nested=1
    options kvm ignore_msrs=1 report_ignored_msrs=0
  '';

  hardware.cpu.amd.updateMicrocode = true;

  # ===== 通用蓝牙设置 =====
  services.blueman.enable = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings.General = {
      Enable = "Source,Sink,Media,Socket";
      Experimental = true;
    };
  };

  environment.systemPackages = with pkgs; [
    bluez
    blueman
    sof-firmware

    libva-utils
    vulkan-loader
    vulkan-tools
  ];

  systemd.user.services.mpris-proxy = {
    description = "MPRIS proxy";
    after = [ "network.target" "sound.target" ];
    wantedBy = [ "default.target" ];
    serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
  };

  # ===== AMD 显卡和图形栈 =====
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      mesa
      libva
      amdvlk
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      mesa
      libva
      amdvlk
    ];
  };

  # ===== AMD 内核参数 =====
  boot.kernelParams = [
    "acpi_backlight=native"
    "amd_pstate=active" 
    "amdgpu.ppfeaturemask=0xffffffff"
  ];
}
