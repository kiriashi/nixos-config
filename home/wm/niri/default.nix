{
  lib,
  pkgs,
  config,
  ...
}:
lib.mkIf config.optional.niri
{
  xdg.configFile = {
    "niri/config.kdl".source = ../dotfiles/niri-config.kdl;
  };

}
