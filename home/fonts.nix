{ 
  ... 
}:

{
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = [
        "NotoSerif Nerd Font"
        "Noto Serif CJK SC"
      ];
      sansSerif = [
        "NotoSans Nerd Font"
        "Noto Sans CJK SC"
      ];
      monospace = [ "Maple Mono NF CN" ];
      emoji = [
        "Noto Color Emoji"
        "Blobmoji"
      ];
    };
  };
}
