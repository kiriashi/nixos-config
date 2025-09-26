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
      nerd-fonts.iosevka
      noto-fonts-color-emoji
      noto-fonts-emoji-blob-bin
      sarasa-gothic
      corefonts
      ]) ++ (with myPkgs; [
      fonts.monolisa-NF
      fonts.monaco-NF
      ]);
    fontconfig = {
      enable = true;
        defaultFonts = {
        serif = [
          "Sarasa Gothic SC"
          "Iosevka Nerd Font"
        ];
        sansSerif = [
          "Sarasa Gothic SC"
          "Iosevka Nerd Font"
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
