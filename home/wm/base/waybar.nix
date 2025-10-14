{
  lib,
  ...
}:

{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      mainBar = {
      layer = "top";
      position = "left";
      spacing = 0;
      weight = 24;
      margin = "12 -2 12 8";
      
      "modules-left" = [ "custom/search" "group/power" "niri/workspaces" ];
      "modules-center" = [ "clock" ];
      "modules-right" = [ "tray" "group/status" ];

      tray = {
        "icon-size" = 14;
        spacing = 12;
      };
      
      "niri/workspaces" = {
        "all-outputs" = true;
        expand = false;
        format = "{icon}";
        "format-icons" = {
          default = "";
          Code = "";
          Browser = "󰆋";
          Chat = "";
          Game = "󰺵";
        };
        tooltip = true;
      };

      "group/status" = {
        orientation = "inherit";
        modules = [
          "battery"
          "cpu"
          "memory"
          "network"
          "bluetooth"
          "wireplumber"
          "backlight"
        ];
        drawer = {
          "transition-duration" = 400;
          "children-class" = "not-battery";
          "transition-left-to-right" = false;
        };
      };

      clock = {
        interval = 1;
        format = "{:%H\n%M\n%S}";
        tooltip = true;
        "tooltip-format" = " {:%Y-%m-%d}，右键清除通知";
        "on-click-right" = "makoctl reload";
      };

      cpu = {
        interval = 1;
        format = "";
        tooltip = true;
      };

      battery = {
        interval = 1;
        states = {
          warning = 30;
          critical = 10;
        };
        format = "{icon}";
        "format-charging" = "";
        "format-plugged" = "";
        "format-alt" = "{icon}";
        "format-icons" = [ "" "" "" "" "" ];
        tooltip = true;
        "tooltip-format" = "🔋{capacity}%";
      };
      
      backlight = {
        "scroll-step" = 5;
        format = "{icon}";
        "format-icons" = [ "󰛩" "󱩎" "󱩏" "󱩐" "󱩑" "󱩒" "󱩓" "󱩔" "󱩕" "󱩖" "󰛨" ];
        "min-length" = 3;
        "on-click" = "brightnessctl set 1%+";
        "on-click-right" = "brightnessctl set 1%-";
        "tooltip-format" = "亮度: {percent}%";
      };
      
      memory = {
        interval = 1;
        format = "";
        tooltip = true;
        "tooltip-format" = "RAM: {used}G / {total}G\nSwap: {swapUsed}G / {swapTotal}G";
        "on-click" = "kitty btop";
      };
      
      network = {
        interval = 1;
        "format-wifi" = "";
        "format-ethernet" = "";
        "format-linked" = "";
        "format-disconnected" = "";
        "tooltip-format" = "{ifname}\nIP: {ipaddr}\n信号强度: {signalStrength}%";
        "on-click" = "nmgui";
      };
      
      wireplumber = {
        "scroll-step" = 5;
        format = "{icon}";
        "format-muted" = "";
        "format-bluetooth" = "󰂰";
        "format-bluetooth-muted" = "";
        "format-icons" = {
          default = [ "" "" "" ];
        };
        "on-click" = "pwvucontrol";
        "ignored-sinks" = [ "AudioRelay Virtual Sink" "Recorder Sink" ];
        "tooltip-format" = "音量: {volume}%";
      };

      bluetooth = {
        interval = 5;
        "format-off" = "󰂲";
        "format-on" = "󰂯";
        "format-connected" = "󰂱";
        "tooltip-format" = "状态: {status}\n设备: {device_alias}\n地址: {device_address}\n电量: {device_battery_percentage}%";
        "on-click" = "blueman-manager";
      };

      "group/power" = {
        orientation = "inherit";
        modules = [
          "custom/caffeine"
          "custom/hibernate"
          "custom/lock"
          "custom/poweroff"
          "custom/reboot"
        ];
        drawer = {
          "transition-duration" = 400;
          "children-class" = "not-lock";
          "transition-left-to-right" = true;
        };
      };

      "custom/lock" = {
        format = "";
        tooltip = true;
        "tooltip-format" = "锁定";
        "on-click" = "niri msg action power-off-monitors && gtklock -d";
      };

      "custom/poweroff" = {
        format = "";
        tooltip = true;
        "tooltip-format" = "关机";
        "on-click" = "systemctl poweroff";
      };

      "custom/reboot" = {
        format = "";
        tooltip = true;
        "tooltip-format" = "重启";
        "on-click" = "systemctl reboot";
      };
      
      "custom/hibernate" = {
        format = "󰒲";
        tooltip = true;
        "tooltip-format" = "休眠";
        "on-click" = "systemctl hibernate";
      };

      "custom/search" = {
        format = "";
        tooltip = true;
        "tooltip-format" = "搜索";
        "on-click" = "fuzzel";
      };
      
      "custom/caffeine" = {
        format = "";
        tooltip = true;
        "tooltip-format" = "左键禁用自动休眠，右键启用自动休眠";
        "on-click" = "systemctl stop --user swayidle.service && notify-send '自动休眠已禁用'";
        "on-click-right" = "systemctl start --user swayidle.service && notify-send '自动休眠已启用'";
      };
    };
  };



    style = lib.mkAfter ''
* {
    font-family: "Iosevka Nerd Font Propo";
    font-weight: 500;
    font-size: 16px;

    border-radius: 12px;
    text-shadow: none;

    transition-property: background;
    transition-duration: 0.2s;
}

window#waybar {
    background-color: transparent;
    font-family: inherit;
}

window#waybar.hidden  {
    opacity: 0.2;
}

tooltip {
    background: @theme_base_color;
    border-bottom: 1px solid @unfocused_borders;
    color: @theme_text_color;
}

tooltip label {
  color: white;
}

.modules-left {
    background-color: rgba(41, 62, 83, 0.8);
    padding: 6px 0px;
}

.modules-center {
    background-color: rgba(41, 62, 83, 0.8);
    padding: 6px 0px;
}

.modules-right {
    background-color: rgba(41, 62, 83, 0.8);
    padding: 6px 0px;
}

#custom-lock,
#custom-poweroff,
#custom-reboot,
#custom-search,
#custom-hibernate,
#custom-caffeine,
#workspaces button,
#tray,
#backlight,
#bluetooth,
#battery,
#cpu,
#memory,
#network,
#wireplumber,
#clock 
{
    padding: 4px 0px;
}


#battery { color: #93abbe; }

#clock { color: #ffffff; }

#cpu { color: #FE968B; }

#backlight { color: #FFD700;}

#memory { color: #FFEAAA; }

#wireplumber { color: #b0f5e5; }

#network { color: #8eb1f2; }

#bluetooth { color: #82aaff; }

#custom-lock { color: #B5E8E0; }

#custom-poweroff { color: #df6a76; }

#custom-reboot { color: #e8c55d; }

#custom-search { color: #ffffff; }

#custom-hibernate { color: #78abdc; }

#custom-caffeine { color: #deb49f; }

#workspaces button.focused { color: #36d792; }
    '';
  };
}
