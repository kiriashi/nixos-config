{
  lib,
  pkgs,
  config,
  ...
}:

{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
  };

  services.swayidle = {
    enable = true;
    events = [
      {
        event = "lock";
        command = "${pkgs.niri}/bin/niri msg action power-off-monitors && ${pkgs.gtklock}/bin/gtklock -d";
      }
      {
        event = "unlock";
        command = "${pkgs.niri}/bin/niri msg action power-on-monitors";
      }
      {
        event = "after-resume";
        command = "${pkgs.gtklock}/bin/gtklock -d";
      }
    ];
    timeouts = [
      {
        timeout = 600;
        command = "${pkgs.niri}/bin/niri msg action power-off-monitors && ${pkgs.gtklock}/bin/gtklock -d";
      }
    ];
  };

  services.mako = {
    enable = true;
    settings = {
      anchor = "top-right";
      sort = "-time";
      layer = "overlay";
      background-color = "#32323295";
      width = 300;
      height = 500;
      padding = 10;
      margin = "10,10,10,10";
      border-size = 4;
      border-color = "#4791db";
      border-radius = 16;
      font = "Sans 10";
      icons = 1;
      icon-path = "~/.nix-profile/share/icons/Papirus";
      max-icon-size = 64;
      default-timeout = 5000;
      ignore-timeout = 1;

      "urgency=high" = {
        border-color = "#bf616a";
        default-timeout = 0;
      };

      "category=mpd" = {
        default-timeout = 2000;
        group-by = "category";
      };
      
      "mode=do-not-disturb" = {
        invisible = 1;
      };
    };
  };

  programs.niriswitcher = {
    enable = true;
    settings = {
      keys = {
        modifier = "Alt";
        switch = {
          next = "Tab";
          prev = "Shift+Tab";
        };
      };
      appearance = {
        system_theme = "light";
        icon_size = 48;
      };
    };
  };

  programs.anyrun = {
    enable = true;
    config = {
      # 窗口位置和大小
      x = { fraction = 0.5; absolute = null; };
      y = { fraction = 0.3; absolute = null; };
      width = { fraction = 0.35; absolute = null; };
      hideIcons = false;
      ignoreExclusiveZones = false;
      layer = "overlay";
      hidePluginInfo = true;
      closeOnClick = true;
      showResultsImmediately = true;
      maxEntries = 30;

      # 加载插件
      plugins = [
        "${anyrunPkgs}/lib/libapplications.so"
        "${anyrunPkgs}/lib/libsymbols.so"
      ];
    };

    # 根据深浅模式切换 CSS
    extraCss = lib.mkIf config.profile.darkMode ''
      * {
        font-family: "monospace";
        font-size: 1.2rem;
        all: unset;
      }

      box#main {
        background: rgba(30, 30, 30, 0.7);
        border-radius: 20px;
        padding: 12px;
        box-shadow:
          0 0 10px rgba(0,0,0,0.5),
          inset 0 0 0 1px rgba(255,255,255,0.05);
      }

      #entry {
        background: rgba(255,255,255,0.05);
        border: 1px solid rgba(255,255,255,0.1);
        border-radius: 12px;
        padding: 4px 8px;
      }

      #match.activatable {
        border-radius: 10px;
        margin: 4px 0;
        padding: 6px;
        transition: 100ms ease-out;
      }

      #match.activatable:hover,
      #match:selected {
        background: rgba(255,255,255,0.1);
      }

      #plugin:hover {
        background: rgba(255,255,255,0.05);
      }
    '' 
    // 浅色模式
    else ''
      * {
        font-family: "monospace";
        font-size: 1.2rem;
        all: unset;
        color: black;
      }

      box#main {
        background: rgba(240, 240, 240, 0.8);
        border-radius: 20px;
        padding: 12px;
        box-shadow:
          0 0 10px rgba(0,0,0,0.2),
          inset 0 0 0 1px rgba(0,0,0,0.05);
      }

      #entry {
        background: rgba(0,0,0,0.03);
        border: 1px solid rgba(0,0,0,0.1);
        border-radius: 12px;
        padding: 4px 8px;
      }

      #match.activatable {
        border-radius: 10px;
        margin: 4px 0;
        padding: 6px;
      }

      #match.activatable:hover,
      #match:selected {
        background: rgba(0,0,0,0.05);
      }

      #plugin:hover {
        background: rgba(0,0,0,0.03);
      }
    '';

    # 插件配置文件示例
    extraConfigFiles."applications.ron".text = ''
      Config(
        maxResults: 20,
        enableIcons: true
      )
    '';

    extraConfigFiles."symbols.ron".text = ''
      Config(
        maxResults: 50
      )
    '';
  };
}
