{
  lib,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    fastfetch
  ];

  xdg.configFile = {
    "fastfetch/config.jsonc".source = ./dotfiles/fastfetch-config.jsonc;
    "fastfetch/nix-corner.png".source = ./dotfiles/nix-corner1.png;
  };
}