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
    "fastfetch/config.jsonc".source = lib.mkForce ./dotfiles/fastfetch-config.jsonc;
    "fastfetch/nix-corner.png".source = lib.mkForce ./dotfiles/nix-corner1.png;
  };
}