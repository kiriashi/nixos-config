{ lib, config, ... }:

with lib;

{
  # 自定义 config.profile 默认值
  options = {
    profile = {
      userName = mkOption {
        type = types.str;
        default = "kiriashi";
        description = "默认主用户名";
      };

      userPasswd = mkOption {
        type = types.str;
        default = "$6$8/ZJ0jr/BWf4at92$PmRuEML2eiCHcRe/vuc54xgSkU.T7bO6ljUqczhkpw3kAv1mTl.PLMOhRuG.yIiEklJGwcHq3szit4PPkZaEM0";
        description = "默认密码哈希";
      };  

        homeDir = mkOption {
          type = types.str;
          default = "/home/kiriashi"; #占位值，用以覆写占位
          description = "默认用户目录";
        };

      userEmail = mkOption {
        type = types.str;
        default = "2244193927@qq.com";
        description = "默认用户邮箱";
      };
  
      hostName = mkOption {
        type = types.str;
        default = "RBP15-2022";
        description = "默认主机名";
      };

      font = mkOption {
        type = types.str;
        default = "JetBrains Mono";
        description = "默认字体";
      };
      
      terminal = mkOption {
        type = types.str;
        default = "kitty";
        description = "默认终端模拟器";
      };

      shell = mkOption {
        type = types.package;
        default = pkgs.fish;
        description = "默认shell";
      };
    
      editor = mkOption {
        type = types.str;
        default = "hx";
        description = "默认编辑器";
      };
    };
    # 自定义项目开关占位值 用以需覆写
    optional = {
      wm = lib.mkEnableOption "wm profile" // {
        default = true;
      };
      hypr = {
        enable = lib.mkEnableOption "hyprland profile" // {
          default = false;
        };
      };
      niri = lib.mkEnableOption "niri profile" // {
        default = true;
      };

      vir = lib.mkEnableOption "virtualisation profile";

      dev = {
        helix = lib.mkEnableOption "helix profile";
        zed = lib.mkEnableOption "zed profile";
        vscode = lib.mkEnableOption "vscode profile";

        node = lib.mkEnableOption "node profile";
      };
    };
  };
  
  # 覆写用户目录
  config = {
    profile.homeDir = mkDefault "/home/${config.profile.userName}";
  };

}