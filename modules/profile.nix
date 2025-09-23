{ lib, ... }:
with lib;
{
  options = {
    profile = {
      userName = mkOption {
        type = types.str;
        default = "kiriashi";
      };
      userEmail = mkOption {
        type = types.str;
        default = "2244193927@qq.com";
      };
      hashedPassword = mkOption {
        type = types.str;
        default = "$6$8/ZJ0jr/BWf4at92$PmRuEML2eiCHcRe/vuc54xgSkU.T7bO6ljUqczhkpw3kAv1mTl.PLMOhRuG.yIiEklJGwcHq3szit4PPkZaEM0";
      };
    };
  };
}