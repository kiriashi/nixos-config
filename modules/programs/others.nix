{ 
  ... 
}:

{
  programs = {
    adb.enable = true;
    git.enable = true;
    appimage = {
      enable = true;
      binfmt = true;
    };
    zoxide.enable = true;
  };

  documentation.nixos.enable = false;

  xdg = {
    portal.enable = true;
    icons.fallbackCursorThemes = [ "Bibata-Modern-Classic" ];
  };
}
