{ 
  ... 
}:

{
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };

    opengl = {
      enable = true;
      extraPackages = with pkgs; [
        amdvlk
        rocmPackages.clr
        rocmPackages.rpp-opencl
        amf
      ];
      dirSupport = true;
      dirSupport32Bit = true;
    };

    enableAllFirmware = true;
    enableRedistributableFirmware = true;

  };
}
