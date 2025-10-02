{ pkgs, selfPkgs, ... }:

{
  imports = [
    ./browser    
    ./fcitx5
    ./games
    ./shell

    ./clipsync.nix
    ./mihomoConfig.nix
    ./media.nix
    ./zathura.nix
    ./mimelist.nix
    ./vir-manager.nix
  ];

  home.packages = (with pkgs; [
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
    nautilus
    code-nautilus
    loupe
    fontforge-gtk
  ]) ++ (with selfPkgs; [
    mihomo-party
  ]);

  # KDE Connect
  services.kdeconnect = {
    enable = true;
    indicator = true;
  };

  # Secret Service
  services.pass-secret-service.enable = true;
  programs.keepassxc.enable = true;
}