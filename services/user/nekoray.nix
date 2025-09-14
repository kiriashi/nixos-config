{
  pkgs,
  ...
}:

{
  programs.nekoray = {
    enable = true;
    package = pkgs.nekoray;
    tunMode.enable = true;
  };
}
