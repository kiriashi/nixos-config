{ lib, config, ... }:
with lib;
{
  # 自定义默认加载程序 - 布伦值控制
  options = {
    optional = {
      wm = lib.mkEnableOption "wm profile" // {
        default = true;
      };
      hypr  = lib.mkEnableOption "hyprland profile" // {
        default = false;
      };
      niri = lib.mkEnableOption "niri profile" // {
        default = true;
      };

      doas = lib.mkEnableOption "doas profile";

      vir = lib.mkEnableOption "virtualisation profile";

      dev = {
        helix = lib.mkEnableOption "helix profile";
        zed = lib.mkEnableOption "zed profile";
        vscode = lib.mkEnableOption "vscode profile";

        go = lib.mkEnableOption "go profile";
        rust = lib.mkEnableOption "rust profile";
        node = lib.mkEnableOption "node profile";
        python = lib.mkEnableOption "python profile";
        java = lib.mkEnableOption "java profile";
      };
    }; 
    
    # 自定义环境变量
    profile = {
      userName = mkOption {
        type = types.str;
        default = "kiriashi";
      };

      fullName = mkOption {
        type = types.str;
        default = "雾岛听风";
      };

      userPasswd = mkOption {
        type = types.str;
        default = "$6$8/ZJ0jr/BWf4at92$PmRuEML2eiCHcRe/vuc54xgSkU.T7bO6ljUqczhkpw3kAv1mTl.PLMOhRuG.yIiEklJGwcHq3szit4PPkZaEM0";
      };  

      homeDir = mkOption {
        type = types.str;
        default = "/home/kiriashi"; #占位值，用以覆写;
      };

      userEmail = mkOption {
        type = types.str;
        default = "2244193927@qq.com";
      };
  
      hostName = mkOption {
        type = types.str;
        default = "RBP15-2022";
      };

      darkMode = mkOption {
        type = types.bool;
        default = true;
      };

      font = mkOption {
        type = types.str;
        default = "JetBrains Mono";
      };
      
      terminal = mkOption {
        type = types.str;
        default = "kitty";
      };

      shell = mkOption {
        type = types.package;
        default = pkgs.fish;
      };

      browser = mkOption {
        type = types.str;
        default = "firefox";
      };
    
      editor = mkOption {
        type = types.str;
        default = "hx";
      };
    };

  };
  
  # 覆写值
  config = {
    profile.homeDir = mkDefault "/home/${config.profile.userName}";
  };

}