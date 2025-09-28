{ ... }:
{
  imports = [
    ../system/boot.nix
    ../system/environment.nix
    ../system/fonts.nix
    ../system/grub.nix
    ../system/i18n.nix
    ../system/network.nix
    ../system/nix.nix
    ../system/security.nix
    ../system/services.nix
    ../system/user.nix
    ../system/zram.nix

    ../system/programs/doas.nix
    ../system/programs/fish.nix
    ../system/programs/git.nix
    ../system/programs/gnupg.nix
    ../system/programs/greetd.nix
    ../system/programs/mihomo.nix
    ../system/programs/niri.nix
    ../system/programs/nix-ld.nix
    ../system/programs/others.nix
    ../system/programs/plymouth.nix
    ../system/programs/poweralertd.nix
    ../system/programs/powerManagement.nix
    ../system/programs/qt6ct.nix
    ../system/programs/steam.nix
    ../system/programs/virtualisation.nix
  ];
}