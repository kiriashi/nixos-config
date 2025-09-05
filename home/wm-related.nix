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

  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "monospace:size=10";
        icons-enabled = "no";
        layer = "overlay";
        line-height = "16";
        terminal = "${pkgs.alacritty}/bin/alacritty";
      };
      colors = {
        background = "2c2c2ccc";

        text = "ffffffff";
        prompt = "4db6acff";
        input = "4db6acff";
        match = "f3777cff";

        selection = "383838cc";
        selection-text = "8fc3a2ff";
        selection-match = "f58e92ff";

        border = "#7fc8ffff";
      };
      border = {
        width = "6";
        radius = "28";
      };
    };
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
}
