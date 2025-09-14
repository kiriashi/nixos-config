{
  pkgs,
  ...
}:

{
  programs.nekoray = {
    enable = true;
    package = pkgs.nekoray;
    tunMode = true;
    serviceMode = true;
  };
}
