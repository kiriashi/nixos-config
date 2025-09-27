{
  selfPkgs,
  pkgs,
  ...
}:

{
  home.packages = (with pkgs; [
    swww
    mpvpaper
    waypaper

    socat
  ]) ++ (with selfPkgs; [
    wallpapers
  ]);

  home.file.wallpapers = {
      source = "${selfPkgs.wallpapers}/share/wallpapers";
      target = "Pictures/wallpapers";
  };

  programs.waybar = {
    enable = true;
    systemd.enable = true;
  };

  xdg.configFile = {
    "waybar/config.jsonc".source = ./dotfiles/waybar-config.jsonc;
    "waybar/style.css".source = ./dotfiles/waybar-style-dark.css;
    # "waybar/style.css".source = ./dotfiles/waybar-style-light.css;

    "fastfetch/config.jsonc".source = ./dotfiles/fastfetch-config.jsonc;
    "fastfetch/nix-corner.png".source = ./dotfiles/nix-corner1.png;
  };

  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "monospace:size=10";
        icons-enabled = "no";
        layer = "overlay";
        line-height = "16";
        terminal = "kitty";
      };
      colors = {
        background = "#2c2c2ce6";

        text = "#ffffffff";
        prompt = "#4db6acff";
        input = "#4db6acff";
        match = "#f3777cff";

        selection = "#383838cc";
        selection-text = "#8fc3a2ff";
        selection-match = "#f58e92ff";

        border = "#85c7d5ff";
      };
      border = {
        width = "4";
        radius = "12";
      };
    };
  };

  services.mako = {
    enable = true;
    settings = {
      anchor = "top-right";
      sort = "-time";
      layer = "overlay";
      background-color = "#2c2c2ce6";
      width = 300;
      height = 500;
      padding = 10;
      margin = "10,10,10,10";
      border-size = 3;
      border-color = "#ddbc7d";
      border-radius = 10;
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
}

