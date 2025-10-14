{
  lib,
  config,
  ...
}:

{
  imports = [
    ./settings.nix
    ./rules.nix
    ./binds.nix
  ];
}
