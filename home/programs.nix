{
  lib,
  pkgs,
  myPkgs,
  inputs,
  ...
}:

{
  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  home.packages = 
  (with pkgs; [
    #图像/视频
    gimp3-with-plugins
    inkscape-with-extensions
    kdePackages.kdenlive
    krita
    ffmpeg
    imagemagick
    nomacs
    mpv
    # 办公套件
    onlyoffice-desktopeditors
    wpsoffice-cn
    #社交娱乐
    qq
    wechat
    wemeet
    telegram-desktop
    thunderbird
    bilibili
    splayer
    #实用工具
    coppwr
    dutree
    btop
    yazi
    #开发工具
    typora
    nixd
    vscode-fhs
    code-cursor-fhs
    #游戏相关
    mangojuice
    mangohud_git

    (bottles.override {
      removeWarningPopup = true;
    })
    
    (heroic.override {
      extraPkgs = pkgs: with pkgs; [
        proton-cachyos_x86_64_v3
        proton-ge-custom
      ];
    })
  ])
  ++ 
  (with myPkgs; [
    # lx-music-desktop
  ]);

  # Zen-Browser
  programs.zen-browser.enable = true;

  # OBS Studio：录屏/直播
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      obs-pipewire-audio-capture
      obs-text-pthread
      obs-vkcapture
      wlrobs
    ];
   };

  # Secret Service（以 pass 提供）与 KeePassXC
  services.pass-secret-service.enable = true;
  programs.keepassxc.enable = true;

  # Helix 编辑器设置
  programs.helix = {
    enable = true;
    settings = {
      theme = "tokyonight_transparent";
      editor = {
        # clipboard-provider = "wl-copy";
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
      };
    };
    languages.language = [
      {
        name = "nix";
        auto-format = true;
        formatter.command = lib.getExe pkgs.nixfmt-rfc-style;
      }
    ];
    themes = {
      tokyonight_transparent = {
        "inherits" = "tokyonight";
        "ui.background" = { };
        "ui.text" = { };
        "ui.help" = { };
        "ui.menu" = { };
        "ui.statusline" = { };
      };
    };
  };

  # KDE Connect：与移动设备互联
  services.kdeconnect = {
    enable = true;
    indicator = true;
  };

  # Firefox（使用 LibreWolf 包）与策略配置
  programs.firefox = {
    enable = true;
    package = pkgs.librewolf;
    languagePacks = [ "zh-CN" ];
    nativeMessagingHosts = with pkgs; [
      keepassxc
    ];

    policies = {
      AutofillAddressEnabled = true;
      AutofillCreditCardEnabled = false;

      DisableAppUpdate = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = false;
      DefaultDownloadDirectory = "\${home}/Downloads";

      # EnableTrackingProtection = {
      #   Value = true;
      #   Locked = true;
      #   Cryptomining = true;
      #   Fingerprinting = true;
      # };

      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      PasswordManagerEnabled = false;
      PromptForDownloadLocation = false;

      RequestedLocales = [ "zh-CN" ];
      SanitizeOnShutdown = {
        Cache = true;
        Cookies = false;
        FormData = false;
        History = false;
        Sessions = false;
        SiteSettings = false;
        Locked = true;
      };
      SearchEngines_Default = "Bing";
    };
  };

  # Kitty 终端设置
  programs.kitty = {
    enable = true;
    enableGitIntegration = true;
    shellIntegration = {
      enableBashIntegration = true;
      enableFishIntegration = true;
    };
    font = {
      package = pkgs.maple-mono.NF-CN;
      name = "Maple Mono NF CN";
      size = 11;
    };
    themeFile = "tokyo_night_night";
    settings = {
      cursor_shape = "beam";
      background_opacity = 0.8;
      background_blur = 10;
      cursor_trail = 1;
      cursor_trail_start_threshold = 0;
    };
  };

}
