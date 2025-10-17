{
  lib,
  ...
}:

{
  programs.niri.settings.binds = {
    # original parts.
    "Mod+Ctrl+R" = lib.mkDefault {
      hotkey-overlay.title = "随机壁纸";
      action.spawn = [ "waypaper" "--random" ];
    };

    "Mod+T" = lib.mkDefault {
      hotkey-overlay.title = "打开终端";
      repeat = false;
      action.spawn = [ "kitty" ];
    };

    "Mod+S" = lib.mkDefault {
      hotkey-overlay.title = "打开搜索";
      repeat = false;
      action.spawn = [ "fuzzel" ];
    };

    "Mod+X" = lib.mkDefault {
      hotkey-overlay.title = "打开剪切板";
      repeat = false;
      action.spawn = [ "sh" "-c" "cliphist list | fuzzel --dmenu -p 'Clipboard > ' | cliphist decode | wl-copy" ];
    };

    "Mod+E" = lib.mkDefault {
      hotkey-overlay.title = "打开文件";
      repeat = false;
      action.spawn = [ "nemo" ];
    };

    "Mod+Y" = lib.mkDefault {
      hotkey-overlay.title = "打开Yazi";
      repeat = false;
      action.spawn = [ "kitty" "-e" "yazi" ];
    };

    "Mod+O" = lib.mkDefault {
      hotkey-overlay.title = "打开录屏";
      repeat = false;
      action.spawn = [ "obs" ];
    };

    "Mod+N" = lib.mkDefault {
      hotkey-overlay.title = "kdeconnect";
      repeat = false;
      action.spawn = [ "kdeconnect-app" ];
    };

    "Mod+B" = lib.mkDefault {
      hotkey-overlay.title = "打开浏览器";
      repeat = false;
      action.spawn = [ "zen-beta" ];
    };

    "Mod+C" = lib.mkDefault {
      hotkey-overlay.title = "打开code";
      repeat = false;
      action.spawn = [ "code" ];
    };

    "Mod+G" = lib.mkDefault {
      hotkey-overlay.title = "打开Gemini";
      repeat = false;
      action.spawn = [ "kitty" "-e" "bash" "-c" "cd ~/Documents && gemini" ];
    };

    "Mod+P" = lib.mkDefault {
      hotkey-overlay.title = "打开音乐";
      repeat = false;
      action.spawn = [ "splayer" ];
    };

    "Mod+M" = lib.mkDefault {
      hotkey-overlay.title = "打开邮件";
      repeat = false;
      action.spawn = [ "thunderbird" ];
    };

    "Super+Alt+L" = lib.mkDefault {
      hotkey-overlay.title = "锁屏";
      repeat = false;
      action.spawn = [ "gtklock" ];
    };

    "Mod+Escape" = lib.mkDefault {
      hotkey-overlay.title = "总览";
      repeat=false;
      action.toggle-overview = { };
    };

    "Mod+R" = lib.mkDefault {
      hotkey-overlay.title = "更改窗口大小";
      action.switch-preset-column-width = { };
    };

    "Mod+F" = lib.mkDefault {
      hotkey-overlay.title = "窗口最大化";
      action.maximize-column = { };
    };
    "Mod+Shift+F" = lib.mkDefault {
      hotkey-overlay.title = "窗口全屏";
      action.fullscreen-window = { }; 
    };

    "Mod+Ctrl+C" = lib.mkDefault {
      hotkey-overlay.title = "将窗口移至中央";
      action.center-column = { }; 
    };

    "Mod+Minus" = lib.mkDefault {
      hotkey-overlay.title = "减小窗口宽度";
      action.set-column-width = "-5%"; 
    };

    "Mod+Equal" = lib.mkDefault {
      hotkey-overlay.title = "增大窗口宽度";
      action.set-column-width = "+5%"; 
    };

    "Mod+Shift+Minus" = lib.mkDefault {
      hotkey-overlay.title = "减小窗口高度";
      action.set-window-height = "-5%"; 
    };

    "Mod+Shift+Equal" = lib.mkDefault {
      hotkey-overlay.title = "增大窗口高度";
      action.set-window-height = "+5%"; 
    };

    "Mod+Ctrl+F" = lib.mkDefault {
      hotkey-overlay.title = "使窗口悬浮";
      action.toggle-window-floating = { };
    };

    # quick help
    "Mod+Alt+Space" = lib.mkDefault {
      hotkey-overlay.title = "显示提示";
      action.show-hotkey-overlay = { };
    };

    # player control
    "XF86AudioRaiseVolume" = lib.mkDefault {
      allow-when-locked = true;
      action.spawn = [ "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+" ];
    };

    "XF86AudioLowerVolume" = lib.mkDefault {
      allow-when-locked = true;
      action.spawn = [ "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-" ];
    };
    "XF86AudioMute" = lib.mkDefault {
      allow-when-locked = true;
      action.spawn = [ "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle" ];
    };
    "XF86AudioMicMute" = lib.mkDefault {
      allow-when-locked = true;
      action.spawn = [ "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle" ];
    };

    "XF86MonBrightnessDown" = lib.mkDefault {
      allow-when-locked = true;
      action.spawn = [ "brightnessctl" "set" "5%-" ];
    };

    "XF86MonBrightnessUp" = lib.mkDefault {
      allow-when-locked = true;
      action.spawn = [ "brightnessctl" "set" "5%+" ];
    };

    # close window
    "Mod+Q" = lib.mkDefault {
      hotkey-overlay.title = "关闭窗口";
      repeat = false;
      action.close-window = { };
    };

    # relative navigation inside workspace
    "Mod+Left".action.focus-column-left = { };
    "Mod+Down".action.focus-window-down = { };
    "Mod+Up".action.focus-window-up = { };
    "Mod+Right".action.focus-column-right = { };
    "Mod+H".action.focus-column-left = { };
    "Mod+J".action.focus-window-down = { };
    "Mod+K".action.focus-window-up = { };
    "Mod+L".action.focus-column-right = { };
    "Mod+Home".action.focus-column-first = { };
    "Mod+End".action.focus-column-last = { };

    # relative moving inside workspace
    "Mod+Ctrl+Left".action.move-column-left = { };
    "Mod+Ctrl+Down".action.move-window-down = { };
    "Mod+Ctrl+Up".action.move-window-up = { };
    "Mod+Ctrl+Right".action.move-column-right = { };
    "Mod+Ctrl+H".action.move-column-left = { };
    "Mod+Ctrl+J".action.move-window-down = { };
    "Mod+Ctrl+K".action.move-window-up = { };
    "Mod+Ctrl+L".action.move-column-right = { };
    "Mod+Ctrl+Home".action.move-column-to-first = { };
    "Mod+Ctrl+End".action.move-column-to-last = { };

    # relative navigation across monitors
    "Mod+Shift+Left".action.focus-monitor-left = { };
    "Mod+Shift+Down".action.focus-monitor-down = { };
    "Mod+Shift+Up".action.focus-monitor-up = { };
    "Mod+Shift+Right".action.focus-monitor-right = { };
    "Mod+Shift+H".action.focus-monitor-left = { };
    "Mod+Shift+J".action.focus-monitor-down = { };
    "Mod+Shift+K".action.focus-monitor-up = { };
    "Mod+Shift+L".action.focus-monitor-right = { };

    # relative moving across monitors
    "Mod+Shift+Ctrl+Left".action.move-column-to-monitor-left = { };
    "Mod+Shift+Ctrl+Down".action.move-column-to-monitor-down = { };
    "Mod+Shift+Ctrl+Up".action.move-column-to-monitor-up = { };
    "Mod+Shift+Ctrl+Right".action.move-column-to-monitor-right = { };
    "Mod+Shift+Ctrl+H".action.move-column-to-monitor-left = { };
    "Mod+Shift+Ctrl+J".action.move-column-to-monitor-down = { };
    "Mod+Shift+Ctrl+K".action.move-column-to-monitor-up = { };
    "Mod+Shift+Ctrl+L".action.move-column-to-monitor-right = { };

    # relative navigation across workspaces
    "Mod+Page_Up".action.focus-workspace-up = { };
    "Mod+Page_Down".action.focus-workspace-down = { };

    # relative moving across workspaces
    "Mod+Ctrl+Page_Up".action.move-column-to-workspace-up = { };
    "Mod+Ctrl+Page_Down".action.move-column-to-workspace-down = { };

    # relative navigation inside workspace using mouse
    "Mod+WheelScrollRight" = lib.mkDefault {
      cooldown-ms = 150;
      action.focus-column-right = { };
    };

    "Mod+WheelScrollLeft" = lib.mkDefault {
      cooldown-ms = 150;
      action.focus-column-left = { };
    };

    "Mod+Shift+WheelScrollDown" = lib.mkDefault {
      cooldown-ms = 150;
      action.focus-column-right = { };
    };

    "Mod+Shift+WheelScrollUp" = lib.mkDefault {
      cooldown-ms = 150;
      action.focus-column-left = { };
    };

    # relative navigation across workspaces using mouse
    "Mod+WheelScrollDown" = lib.mkDefault {
      cooldown-ms = 150;
      action.focus-workspace-down = { };
    };

    "Mod+WheelScrollUp" = lib.mkDefault {
      cooldown-ms = 150;
      action.focus-workspace-up = { };
    };

    # absolute navigation across workspace
    "Mod+1".action.focus-workspace = 1;
    "Mod+2".action.focus-workspace = 2;
    "Mod+3".action.focus-workspace = 3;
    "Mod+4".action.focus-workspace = 4;
    "Mod+5".action.focus-workspace = 5;
    "Mod+6".action.focus-workspace = 6;
    "Mod+7".action.focus-workspace = 7;
    "Mod+8".action.focus-workspace = 8;
    "Mod+9".action.focus-workspace = 9;
    "Mod+0".action.focus-workspace = 0;

    # back-and-forth
    "Alt+Tab".action.focus-workspace-previous = { };

    # absolute moving across workspace
    "Mod+Shift+1".action.move-column-to-workspace = 1;
    "Mod+Shift+2".action.move-column-to-workspace = 2;
    "Mod+Shift+3".action.move-column-to-workspace = 3;
    "Mod+Shift+4".action.move-column-to-workspace = 4;
    "Mod+Shift+5".action.move-column-to-workspace = 5;
    "Mod+Shift+6".action.move-column-to-workspace = 6;
    "Mod+Shift+7".action.move-column-to-workspace = 7;
    "Mod+Shift+8".action.move-column-to-workspace = 8;
    "Mod+Shift+9".action.move-column-to-workspace = 9;
    "Mod+Shift+0".action.move-column-to-workspace = 0;

    # screenshot.
    "Print".action.screenshot = { }; 
    "Ctrl+Print".action.screenshot-screen = { }; 
    "Alt+Print".action.screenshot-window = { }; 

    # exit
    "Mod+Shift+E".action.quit = { };
  };
}
