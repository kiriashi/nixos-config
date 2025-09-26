{
  pkgs,
  ...
}:

{
  xdg.configFile = {
    "niri/config.kdl".source = ../dotfiles/niri-config.kdl;
  };

}
