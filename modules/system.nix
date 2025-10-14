{ ... }:
{
  imports = [
    ./system/boot.nix
    ./system/environment.nix
    ./system/fonts.nix
    ./system/grub.nix
    ./system/i18n.nix
    ./system/network.nix
    ./system/nix.nix
    ./system/security.nix
    ./system/services.nix
    ./system/user.nix
    ./system/zram.nix
  ];
}