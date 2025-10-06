{ 
  lib,
  config,
  pkgs, 
  ... 
}:
lib.mkIf config.optional.dev.java
{
  programs.java = {
    enable = true;
    package = pkgs.zulu.override {
      enableJavaFX = true;
    };
  };

  home.sessionVariables  = {
    _JAVA_OPTIONS = "-Dawt.useSystemAAFontSettings=lcd";
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };
}
