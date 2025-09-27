{ 
  inputs,
  ... 
  }:
{
  imports = [ inputs.zen-browser.homeModules.beta ];

  programs = {
    zen-browser = {
    enable = true;
    languagePacks = [ "zh-CN" ];
    policies ={
      RequestedLocales = [ "zh-CN" ];
    };
    
    };
  };
}