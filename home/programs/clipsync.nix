{ config, lib, pkgs, ... }:

let
  clipsyncScript = pkgs.writeShellScriptBin "clipsync" ''
    #!/usr/bin/env bash
    # Clipboard sync for Wayland <-> XWayland + cliphist

    WAY_CLIP=""
    X11_CLIP=""
    X11_PRIMARY=""

    CLIPHIST_CMD="cliphist add"

    while true; do
        # 获取 Wayland 剪贴板内容
        NEW_WAY=$(wl-paste --no-newline 2>/dev/null || echo "")

        # 获取 X11 CLIPBOARD 和 PRIMARY 内容
        NEW_X11_CLIP=$(DISPLAY=:0 xclip -selection clipboard -o 2>/dev/null || echo "")
        NEW_X11_PRIMARY=$(DISPLAY=:0 xclip -selection primary -o 2>/dev/null || echo "")
        
        # 合并 X11 剪贴板内容（优先使用 CLIPBOARD)
        NEW_X11=$NEW_X11_CLIP
        [ -z "$NEW_X11" ] && NEW_X11=$NEW_X11_PRIMARY

        # Wayland -> X11
        if [ "$NEW_WAY" != "$WAY_CLIP" ] && [ -n "$NEW_WAY" ]; then
            # 同时设置 CLIPBOARD 和 PRIMARY
            echo -n "$NEW_WAY" | DISPLAY=:0 xclip -selection clipboard
            echo -n "$NEW_WAY" | DISPLAY=:0 xclip -selection primary
            WAY_CLIP="$NEW_WAY"
            X11_CLIP="$NEW_WAY"
            X11_PRIMARY="$NEW_WAY"

            # 更新 cliphist
            echo -n "$NEW_WAY" | $CLIPHIST_CMD
        fi

        # X11 -> Wayland
        if ([ "$NEW_X11_CLIP" != "$X11_CLIP" ] || [ "$NEW_X11_PRIMARY" != "$X11_PRIMARY" ]) && [ -n "$NEW_X11" ]; then
            echo -n "$NEW_X11" | wl-copy
            X11_CLIP="$NEW_X11_CLIP"
            X11_PRIMARY="$NEW_X11_PRIMARY"
            WAY_CLIP="$NEW_X11"

            # 更新 cliphist
            echo -n "$NEW_X11" | $CLIPHIST_CMD
        fi

        sleep 0.5
    done
  '';

  clipsyncService = {
    Unit = {
      Description = "Clipboard sync between Wayland and X11";
      After = [ "graphical.target" ];
    };
    Service = {
      ExecStart = "${clipsyncScript}/bin/clipsync";
      Restart = "always";
      RestartSec = "5s";
      Environment = [
        "DISPLAY=:0"
        "WAYLAND_DISPLAY=wayland-1"
        "XDG_RUNTIME_DIR=/run/user/%U"
      ];
    };
    Install = {
      WantedBy = [ "graphical.target" ];
    };
  };
in 
{
  options = {
    clipsync = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Enable clipboard sync between Wayland and X11";
      };
    };
  };

  config = lib.mkIf config.clipsync.enable {
    systemd.user.services.clipsync = clipsyncService;
  };
}