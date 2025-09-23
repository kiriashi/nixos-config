{ 
  pkgs,
  ... 
}:

{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      addons = with pkgs; [
        fcitx5-rime
        librime
        librime-lua
        librime-octagram
      ];
      waylandFrontend = true;
    };
  };
}
