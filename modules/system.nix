{ ... }:

{
  imports = [
    ../system/boot.nix
    ../system/environment.nix
    ../system/fonts.nix
    ../system/hardware.nix
    ../system/hardware-configuration.nix
    ../system/i18n.nix
    ../system/security.nix
    ../system/services.nix
    ../system/user.nix
    ../system/zram.nix
  ];

  networking.hostName = "RBP152022";

  system = {
    stateVersion = "25.11";
    autoUpgrade.channel = "https://mirrors.ustc.edu.cn/nix-channels/nixos-unstable";
  };
}
