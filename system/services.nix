{
  lib,
  pkgs,
  ...
}:

{
  services = {
    pipewire = lib.mkForce {
      enable = true;
      pulse.enable = true;
      jack.enable = true;
      alsa.support32Bit = true;
      wireplumber.enable = true;
    };
    pulseaudio.enable = false;

    fstrim = {
      enable = true;
      interval = "weekly";
    };

    scx = {
      enable = true;
      scheduler = "scx_rusty";
    };

    xserver = {
      excludePackages = [ pkgs.xterm ];
      upscaleDefaultCursor = true;
    };
    
    flatpak.enable = true;

    usbguard.dbus.enable = true;
    udisks2.enable = true;
    upower.enable = true;

    envfs.enable = true;
    
    speechd.enable = lib.mkForce false;
  };
}
