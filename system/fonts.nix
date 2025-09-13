{
  pkgs,
  lib,
  ...
}:

{
  imports = [ ../home/fonts.nix ];

  fonts = lib.mkForce {
    enableDefaultPackages = false;
    fontconfig.enable = true;
    fontDir.enable = true;
    packages = with pkgs; [
      maple-mono.NF-CN
      nerd-fonts.noto
      noto-fonts-color-emoji
      noto-fonts-emoji-blob-bin
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      wqy_microhei
    ];
  };
}
