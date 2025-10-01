{
  pkgs,
  lib,
  config,
  ...
}:

{
  systemd.services.fprintd = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig.Type = "simple";
  };

  services.fprintd.enable = true;

  security.pam.services.gtklock = lib.mkIf (config.programs.gtklock.enable) {
    text = ''
      auth sufficient ${pkgs.linux-pam}/lib/security/pam_unix.so try_first_pass likeauth nullok
      auth sufficient ${pkgs.fprintd}/lib/security/pam_fprintd.so
      auth include    login
    '';
  };
}