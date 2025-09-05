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
    ../system/zram.nix
    ../system/user.nix
  ];

  networking.hostName = "Kiriashi-NixOS";

  system = {
    stateVersion = "25.11";
    autoUpgrade.channel = "https://mirrors.ustc.edu.cn/nix-channels/nixos-unstable";
  };
}
