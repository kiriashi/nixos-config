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
    
    sshPublicKey = mkOption {
      type = types.str;
      default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC...";
      description = "用户 SSH 公钥";
    };
    
    hostname = mkOption {
      type = types.str;
      default = "RBP15-2022";
      description = "系统主机名";
    };
    
    timezone = mkOption {
      type = types.str;
      default = "Asia/Shanghai";
      description = "系统时区";
    };
    
    locale = mkOption {
      type = types.str;
      default = "zh_CN.UTF-8";
      description = "系统区域设置";
    };
    
    hotspotSSID = mkOption {
      type = types.str;
      default = "Nixos";
      description = "移动热点 SSID";
    };
    
    wifiPassword = mkOption {
      type = types.str;
      default = "12345678";
      description = "移动热点 密码";
    };
    
    defaultShell = mkOption {
      type = types.str;
      default = "${pkgs.kitty}/bin/kitty";
      description = "默认 shell";
    };
    
    editor = mkOption {
      type = types.str;
      default = "hliex";
      description = "默认编辑器";
    };
    
  };
}