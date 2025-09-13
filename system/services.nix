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
    # 把 meson.build 里的 /bin/bash 替换成 nix store 里的 bash
    substituteInPlace meson.build \
      --replace "/bin/bash" "${lib.getExe pkgs.bash}"

    # 修正 meson-scripts 下所有脚本的 shebang
    patchShebangs meson-scripts
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
