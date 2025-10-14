{
  ...
}:

{
  programs.niri.settings = {
    layer-rules = [
      {
        matches = [
          { namespace = "^notifications$"; }
        ];

        block-out-from = "screencast";
      }
    ];

    workspaces = {
      "Browser" = {};
      "Code" = {};
      "Chat" = {};
      "Game" = {};
    };

    window-rules = [
      {
        matches = [{}];

        geometry-corner-radius = {
          top-left = 12.0;
          top-right = 12.0;
          bottom-left = 12.0;
          bottom-right = 12.0;
        };

        clip-to-geometry = true;
        draw-border-with-background = false;
      }
      
      {
        matches = [
          { is-active = false; }
        ];

        opacity = 0.9;

        shadow.enable = false;
      }

      {
        matches = [
          { app-id = "firefox"; }
          { app-id = "zen-beta"; }
        ];
    
        open-maximized = true;
        open-on-workspace = "Browser";
      }

      {
        matches = [
          { title = "r#'.*Lapce$'#"; }
          { app-id = "code"; }
          { app-id = "cursor"; }
          { app-id = "zed"; }
          { app-id = "typora"; }
        ];
    
        open-maximized = true;
        open-on-workspace = "Code";
      }

      {
        matches = [
          { app-id = "thunderbird"; }
          { app-id = "wechat";}
          { app-id = "org.telegram.desktop";}
          { app-id = "QQ";}
          { app-id = "com.alibabainc.dingtalk";}
          { app-id = "wemeetapp";}
        ];
    
        open-on-workspace = "Chat";
      }

      {
        matches = [
          {app-id = "heroic";}
          {app-id = "steam";}
          {app-id = "r#'^steam_app'#"; }
          {app-id = ".gamescope-wrapped";}

          {app-id = "osu!";}
    
          {app-id = "org.prismlauncher.PrismLauncher";}
          {app-id = "org.jackhuang.hmcl.Launcher";}
        ];
    
        open-on-workspace = "Game";
      }

      {
        matches = [
          { app-id = "pwvucontrol"; }
          { app-id = "missioncenter"; }
          { app-id = "nm-connection-editor"; }
          { app-id = "mpv"; }
          { app-id = "waypaper"; }
          { app-id = "r#'.*\.exe$'#"; }
          { app-id = "QtScrcpy"; }
    
          { app-id = "xdg-desktop-portal-gtk"; }
          { app-id = "org.gnome.FileRoller"; }
          { app-id = "org.kde.polkit-kde-authentication-agent-1"; }
          { app-id = "org.keepassxc.KeePassXC"; }
          { app-id = "fcitx"; }
        ];
    
        open-floating = true;
      }


      {
        matches = [
          { app-id = "org.kde.kdenlive"; }
          { app-id = "org.inkscape.Inkscape"; }
          { app-id = "gimp"; }
    
          { title = "r#'.*Lapce$'#"; }
          { app-id = "code"; }

          { app-id = "Microsoft Windows"; }
        ];
    
        open-maximized = true;
      }

      {
        matches = [
          { app-id = "waydroid"; }
          { app-id = "gamescope"; }
          { app-id = "r#'steam_app*.'#"; }
        ];

        open-fullscreen = true;
      }

      {
        matches = [
          { app-id = "kitty"; }
        ];

        default-column-width = {
          proportion = 1. / 2.;
        };
      }

      {
        matches = [
          { app-id = "r#'^org\.keepassxc\.KeePassXC$'#"; }
          { app-id = "r#'^org\.gnome\.World\.Secrets$'#"; }
        ];

        block-out-from = "screen-capture";
      }

      {
        matches = [
          { app-id = "steam";}
          { title = "r#'^notificationtoasts_\d+_desktop$'#"; }
        ];

        default-floating-position = {
          x = 10;
          y = 10;
          relative-to = "bottom-right";
        };
      }
    ];
  };

}
