{ config, lib, pkgs, ... }:

with lib;

let
  # 剪贴板同步脚本
  clipboardSyncScript = pkgs.writeShellScript "clipboard-sync.sh" ''
    WAYLAND_CLIP=""
    X11_CLIP=""
    while true; do
      NEW_WAYLAND=$(${pkgs.wl-clipboard}/bin/wl-paste --no-newline 2>/dev/null || echo "")
      NEW_X11=$(${pkgs.xclip}/bin/xclip -selection clipboard -o 2>/dev/null || echo "")
      if [ "$NEW_WAYLAND" != "$WAYLAND_CLIP" ]; then
        echo -n "$NEW_WAYLAND" | ${pkgs.xclip}/bin/xclip -selection clipboard
        WAYLAND_CLIP="$NEW_WAYLAND"
        X11_CLIP="$NEW_WAYLAND"
      fi
      if [ "$NEW_X11" != "$X11_CLIP" ]; then
        echo -n "$NEW_X11" | ${pkgs.wl-clipboard}/bin/wl-copy
        X11_CLIP="$NEW_X11"
        WAYLAND_CLIP="$NEW_X11"
      fi
      sleep 0.5
    done
  '';
in {
  options.services.clipboard-sync = {
    enable = mkEnableOption "Clipboard sync between Wayland and X11";
  };

  config = mkIf config.services.clipboard-sync.enable {
    home.packages = with pkgs; [ wl-clipboard xclip ];

    systemd.user.services.clipboard-sync = {
      Unit = {
        Description = "Clipboard Sync between Wayland and X11";
        After = [ "graphical-session.target" ];
      };
      Service = {
        Type = "simple";
        Environment = "WAYLAND_DISPLAY=${config.wayland.windowManager.niri.settings.waylandDisplay or "wayland-1"}";
        ExecStart = "${clipboardSyncScript}";
        Restart = "always";
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };
}
