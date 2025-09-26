{ pkgs, ... }:

{
  imports = [
    ./fcitx5
    ./browser
    ./shell

    ./clipsync.nix
    ./media.nix
    ./zathura.nix
    ./mimelist.nix
    ./vir-manager.nix
  ];

  home.packages = with pkgs; [
    xdg-utils

    # Social Apps
    telegram-desktop
    qq
    wechat
    thunderbird

    claude-code
    gemini-cli
    code-cursor-fhs

    wemeet
    libreoffice
    wpsoffice-cn

    nautilus
    sushi
    loupe
    typora
    mission-center
    fontforge-gtk
 
    # Games tool
    mangojuice
    mangohud_git
    # games wine
    (bottles.override {
      removeWarningPopup = true;
    })
    # epic
    (heroic.override {
      extraPkgs = pkgs: with pkgs; [
        proton-cachyos_x86_64_v4
        proton-ge-custom
      ];
    })
  ];

  # KDE Connect：与移动设备互联
  services.kdeconnect = {
    enable = true;
    indicator = true;
  };

  # Secret Service（以 pass 提供）与 KeePassXC
  services.pass-secret-service.enable = true;
  programs.keepassxc.enable = true;
}