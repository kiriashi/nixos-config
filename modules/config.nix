{ ... }:
{
  imports = [
    ../config/system/boot.nix
    ../config/system/environment.nix
    ../config/system/fonts.nix
    ../config/system/grub.nix
    ../config/system/i18n.nix
    ../config/system/network.nix
    ../config/system/nix.nix
    ../config/system/security.nix
    ../config/system/services.nix
    ../config/system/user.nix
    ../config/system/zram.nix

    ../config/services/doas.nix
    ../config/services/fcitx5.nix
    ../config/services/fish.nix
    ../config/services/git.nix
    ../config/services/gnupg.nix
    ../config/services/greetd.nix
    ../config/services/mihomo.nix
    ../config/services/niri.nix
    ../config/services/nix-ld.nix
    ../config/services/others.nix
    ../config/services/plymouth.nix
    ../config/services/poweralertd.nix
    ../config/services/powerManagement.nix
    ../config/services/qt6ct.nix
    ../config/services/steam.nix
    ../config/services/virtualisation.nix
  ];
}