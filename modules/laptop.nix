{ ... }:

{
  imports = [
    ./options/laptop.nix
    ../hosts/laptop/hardware.nix
    ../hosts/laptop/hardware-configuration.nix
  ];
  
}