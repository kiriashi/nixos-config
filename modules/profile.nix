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
      default = "RBP152022";
      description = "系统主机名";
    };
    
    timezone = mkOption {
      type = types.str;
      default = "Asia/Shanghai";
      description = "系统时区";
    };
    
    locale = mkOption {
      type = types.str;
      default = "en_US.UTF-8";
      description = "系统区域设置";
    };
    
    wifiSSID = mkOption {
      type = types.str;
      default = "MyWiFi";
      description = "默认 WiFi SSID";
    };
    
    wifiPassword = mkOption {
      type = types.str;
      default = "securepassword";
      description = "默认 WiFi 密码";
    };
    
    defaultShell = mkOption {
      type = types.str;
      default = "${pkgs.fish}/bin/fish";
      description = "默认 shell";
    };
    
    editor = mkOption {
      type = types.str;
      default = "hliex";
      description = "默认编辑器";
    };
    
  };
  
  config = {
    profile = {
      userName = mkDefault "kiriashi";
      userEmail = mkDefault "2244193927@qq.com";
      hashedPassword = mkDefault "$6$8/ZJ0jr/BWf4at92$PmRuEML2eiCHcRe/vuc54xgSkU.T7bO6ljUqczhkpw3kAv1mTl.PLMOhRuG.yIiEklJGwcHq3szit4PPkZaEM0";
      hostname = mkDefault "RBP152022";
      timezone = mkDefault "Asia/Shanghai";
      locale = mkDefault "zh_CN.UTF-8";
    };
  };
}