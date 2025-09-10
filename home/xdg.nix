{ 
  pkgs, 
  ... 
}:

{

  xdg = {
    enable = true;
    userDirs.enable = true;
    userDirs.createDirectories = true;

    desktopEntries = {

      qq = {
        name = "QQ";
        exec = "${pkgs.qq}/bin/qq --enable-wayland-ime --wayland-text-input-version=3 %U";
        icon = "${pkgs.qq}/share/icons/hicolor/512x512/apps/qq.png";
        categories = [ "Network" ];
        comment = "轻松做自己";
      };

      lx-music = {
        name = "LX Music";
        exec = "lx-music-desktop";
        icon = "${pkgs.lx-music-desltop}/share/icons/512x512.png";
        categories = [ "Audio" ];
        comment = "轻量音乐播放器";
      };

      labwc = {
        name = "labwc";
        exec = "${pkgs.labwc}/bin/labwc";
      };
      
      mcaselector = {
        name = "mcaselector";
        exec = "mcaselector";
      };

    };
  };
    
}
