{ 
  lib,
  myPkgs,
  ... 
}:

{
  boot.loader = {
    systemd-boot.enable = lib.mkForce false;
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      configurationName = "NixOS";

      useOSProber = true;
      # default = "Windows Boot Manager (on /dev/nvme0n1p1)";

      # gfxmodeEfi = "1200x750";
      theme = myPkgs.Themes.grub;
    };
    timeout = 5;
  };
}
