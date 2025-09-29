{ lib, config, pkgs, ... }:

lib.mkIf config.optional.dev.lua {
  home.packages = with pkgs; [
    lua
    luajit
    luarocks
    stylua
    vscode-extensions.sumneko.lua
  ];
}