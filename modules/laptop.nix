{ ... }:

{
  imports = [
    ./potions/laptop.nix
    ../hosts/laptop/hardware.nix
    ../hosts/laptop/hardware-configuration.nix
  ];
  
}