{
  pkgs,
  config,
  ...
}:
{
  home.packages = with pkgs; [
    wl-clipboard
    xclip
    clipman
  ];

  systemd.user.services.clip-sync = {
    description = "Wayland <-> X11 clipboard sync";
    serviceConfig.ExecStart = "${pkgs.wl-clipboard}/bin/wl-paste --watch ${pkgs.xclip}/bin/xclip -selection clipboard -i";
    wantedBy = [ "default.target" ];
  };
}