{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
{
  programs.mangohud = {
    enable = true;
    enableSessionWide = true;
    package = pkgs.mangohud; # .overrideAttrs (_finalAttrs: previousAttrs: {
    #  patches = previousAttrs.patches ++ [../../../pkgs/mangohud/media-player-fix.patch];
    # });
    
    settings = {
      background_alpha = lib.mkForce 0.0;
      font_size = lib.mkForce 16;
      font_size_text = lib.mkForce 16;
      no_small_font = true;
      font_scale = lib.mkForce 1.0;
      font_scale_media_player = 1.0;
      
      hud_no_margin = true;
      text_outline_thickness = 1.5;
      horizontal = true;
      time = true;
      vram = true;

      time_no_label = true;
      time_format = "%H:%M";
      frame_timing = 0;
      media_player = true;
      media_player_format = "{artist} - {title}";

      fps_value = "90,144,240";
      fps_color_change = "F00000,FFD700,00FF00";

      gpu = true;
      gpu_color = "F00000";
      gpu_load_color = "00FF00,FFD700,F00000";

      cpu = true;
      cpu_color = "0000FF";
      cpu_load_color = "00FF00,FFD700,F00000";

      ram = true;
      ram_color = "F5C2E7";
    };
  };
}