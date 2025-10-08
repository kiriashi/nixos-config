{
  pkgs,
  lib,
  ...
}:

{
  fonts = lib.mkForce {
    enableDefaultPackages = false;
    fontDir.enable = true;
    packages = with pkgs; [
      maple-mono.NF-CN
      wqy_microhei
      nerd-fonts.noto
      noto-fonts-color-emoji
      noto-fonts-emoji-blob-bin
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif

      self.fonts.monolisa-NF
      self.fonts.monaco-NF
    ];
    fontconfig = {
      enable = true;
        defaultFonts = {
        serif = [
          "WenQuanYi Micro Hei"
          "NotoSerif Nerd Font"
        ];
        sansSerif = [
          "WenQuanYi Micro Hei"
          "NotoSans Nerd Font"
        ];
        monospace = [
          "MonoLisa Nerd Font"
          # "Monaco Nerd Font"
          # "Maple Mono NF CN"
        ];
        emoji = [
          "Noto Color Emoji"
          "Blobmoji"
        ];
      };
    };
  };
}
