{ pkgs, ... }:

{
  imports = [
    ./browser    
    ./fcitx5
    ./games
    ./shell

    ./media.nix
    ./zathura.nix
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
    nemo-with-extensions
    file-roller
    loupe
    fontforge-gtk
  ];

  # KDE Connect
  services.kdeconnect = {
    enable = true;
    indicator = false;
  };

  # Secret Service
  services.pass-secret-service.enable = true;
  programs.keepassxc.enable = true;
}