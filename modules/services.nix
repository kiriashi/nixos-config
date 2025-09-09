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
    ../services/system/niri.nix
    ../services/system/nix.nix
    ../services/system/nix-ld.nix
    ../services/system/others.nix
    ../services/system/plymouth.nix
    ../services/system/powerManagement.nix

    ../services/user/clash-verge.nix
    ../services/user/fcitx5.nix
    ../services/user/qt6ct.nix
    ../services/user/poweralertd.nix
    ../services/user/shell.nix
    ../services/user/steam.nix
  ];

  nixpkgs.config.permittedInsecurePackages = [

  ];

}
