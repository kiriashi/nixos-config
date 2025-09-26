{
  lib,
  pkgs,
  config,
  ...
}:

{
  dconf = {
    settings = {
      "org/gnome/desktop/applications/terminal" = {
        exec = "kitty";
      };
      "org/cinnamon/desktop/applications/terminal" = {
        exec = "kitty";
      };
    };
  };
  
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
      size = 12;
    };
    themeFile = "tokyo_night_night";
    settings = {
      italic_font = "auto";
      bold_italic_font = "auto";
      cursor_shape = "beam";
      background_opacity = 0.8;
      background_blur = 10;
      cursor_trail = 1;
      cursor_trail_start_threshold = 0;
    };
  };
}