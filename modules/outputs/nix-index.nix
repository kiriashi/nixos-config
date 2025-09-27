{ inputs, lib, ... }:

{
  imports = [ inputs.niri-flake.nixosModules.niri ];

  niri-flake.cache.enable = true;
  nixpkgs.overlays = [ inputs.niri-flake.overlays.niri ];
  services.gnome.gnome-keyring.enable = lib.mkForce false;
}