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
      sarasa-gothic
      nerd-fonts.iosevka
      noto-fonts-color-emoji
      noto-fonts-emoji-blob-bin

      self.fonts.monolisa-NF
      self.fonts.monaco-NF
    ];
    fontconfig = {
      enable = true;
        defaultFonts = {
        serif = [
          "Sarasa Gothic SC"
        ];
        sansSerif = [
          "Sarasa Gothic SC"
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
