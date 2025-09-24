{
  pkgs,
  myPkgs,
  lib,
  ...
}:

{
  fonts = lib.mkForce {
    enableDefaultPackages = false;
    fontDir.enable = true;
    packages = (with pkgs; [
      maple-mono.NF-CN
      nerd-fonts.noto
      noto-fonts-color-emoji
      noto-fonts-emoji-blob-bin
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      wqy_microhei
    ]) ++ (with myPkgs; [
    fonts.monolisa-NF
    fonts.monaco-NF
    ]);

    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [
          "WenQuanYi Micro Hei"
          "NotoSerif Nerd Font"
          "Noto Serif CJK SC"
        ];
        sansSerif = [
          "WenQuanYi Micro Hei"
          "NotoSans Nerd Font"
          "Noto Sans CJK SC"
        ];
        monospace = [
          # "Maple Mono NF CN"
          "MonoLisa Nerd Font"
          # Monaco Nerd Font
        ];
        emoji = [
          "Noto Color Emoji"
          "Blobmoji"
        ];
      };
    };
  };
}
