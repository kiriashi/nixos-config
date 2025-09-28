{ 
  lib,
  selfPkgs,
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
      theme = selfPkgs.arknights-grub-theme;
    };
    timeout = 5;
  };
}
