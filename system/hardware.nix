{ 
  pkgs,
  ... 
}:

{
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };

    enableAllFirmware = true;
    enableRedistributableFirmware = true;

  };
}
