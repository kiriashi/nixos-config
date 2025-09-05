{ 
  lib, 
  ... 
}:

{
  boot.loader = {
    systemd-boot.enable = lib.mkForce false;
    grub = {
      enable = true;
      device = "nodev";
      useOSProber = true;
      efiSupport = true;
      gfxmodeEfi = auto;
    };
    timeout = 5;
  };
}
