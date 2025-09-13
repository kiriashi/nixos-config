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
      package = pkgs.scx_git.full.overrideAttrs (old: {
  postPatch = (old.postPatch or "") + ''
    substituteInPlace meson.build \
      --replace-fail '/bin/bash' '${lib.getExe pkgs.bash}' \
      --replace-fail '/usr/bin/env' '${lib.getExe pkgs.coreutils}/bin/env'
  '';
});
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
