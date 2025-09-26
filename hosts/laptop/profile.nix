{ lib, ... }:

with lib;

{
  options.profile = {
    userName = mkOption {
      type = types.str;
      default = "kiriashi";
      description = "系统主用户名";
    };
    
    userEmail = mkOption {
      type = types.str;
      default = "2244193927@qq.com";
      description = "用户邮箱";
    };
    
    hashedPassword = mkOption {
      type = types.str;
      default = "$6$8/ZJ0jr/BWf4at92$PmRuEML2eiCHcRe/vuc54xgSkU.T7bO6ljUqczhkpw3kAv1mTl.PLMOhRuG.yIiEklJGwcHq3szit4PPkZaEM0";
      description = "用户密码哈希";
    };

    homeDir = mkOption {
      type = types.str;
      default = config: "/home/${config.profile.userName}";
      description = "默认用户目录";
    };
 
    hostName = mkOption {
      type = types.str;
      default = "RBP15-2022";
      description = "系统主机名";
    };
    
    hotspotSSID = mkOption {
      type = types.str;
      default = "Nixos";
      description = "移动热点名称";
    };
    
    hotspotPasswd = mkOption {
      type = types.str;
      default = "12345678";
      description = "移动热点密码";
    };
    
    terminal = mkOption {
      type = types.str;
      default = "kitty.desktop";
      description = "默认终端模拟器";
    };

    shell = mkOption {
      type = types.package;
      default = pkgs.fish;
      description = "默认shell";
    };
    
    editor = mkOption {
      type = types.str;
      default = "hliex";
      description = "默认编辑器";
    };
    
  };
}