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
    # System tools
    xdg-utils 
    mission-center

    # Social Apps
    telegram-desktop
    qq
    wechat
    wemeet
    thunderbird

    # AI
    claude-code
    gemini-cli-bin
    code-cursor-fhs
    
    # Office
    typora
    onlyoffice-desktopeditors
    wpsoffice-cn

    # File manager
    loupe
    nautilus
    code-nautilus
    fontforge-gtk
    
    # Games tool
    mangojuice
    mangohud_git
    (bottles.override {
      removeWarningPopup = true;
    })
    (heroic.override {
      extraPkgs = pkgs: with pkgs; [
        proton-cachyos_x86_64_v4
        proton-ge-custom
      ];
    })
  ];

  # KDE Connect
  services.kdeconnect = {
    enable = true;
    indicator = true;
  };

  # Secret Service
  services.pass-secret-service.enable = true;
  programs.keepassxc.enable = true;
}