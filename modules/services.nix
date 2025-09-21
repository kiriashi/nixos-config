{ ... }:

{
  imports = [
    ../services/system/connman.nix
    ../services/system/doas.nix
    ../services/system/fish.nix
    ../services/system/git.nix
    ../services/system/gnupg.nix
    ../services/system/greetd.nix
    ../services/system/grub.nix
    ../services/system/mihomo.nix
    ../services/system/niri.nix
    ../services/system/nix.nix
    ../services/system/nix-ld.nix
    ../services/system/others.nix
    ../services/system/plymouth.nix
    ../services/system/powerManagement.nix

    ../services/user/fcitx5.nix
    ../services/user/qt6ct.nix
    ../services/user/poweralertd.nix
    ../services/user/steam.nix
    ../services/user/virtualisation.nix
  ];

  nixpkgs.config.permittedInsecurePackages = [

  ];

}
