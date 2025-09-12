{
  config,
  myPkgs,
  ...
}:
{
  home.packages = [ myPkgs.wallpaper ];

  home.file = {
    nix-profile = {
      source = config.home.path;
      target = ".nix-profile";
    };

    rime-wanxiang = {
      source = ../home/fcitx5/rime/user_exclude_file.txt;
      target = ".local/share/fcitx5/rime/custom/user_exclude_file.txt";
    };

    rime-wanxiang-update = {
      source = ../home/fcitx5/rime/wanxiang-update.sh;
      target = ".local/share/fcitx5/rime/wanxiang-update.sh";
    };

    wallpaper = {
      source = "${myPkgs.wallpaper}/share/wallpapers";
      target = "Pictures/wallpapers";
    };

    theme1 = {
      source = "${config.home.path}/share/themes";
      target = ".themes";
    };

    theme2 = {
      source = "${config.home.path}/share/themes";
      target = ".local/share/themes";
    };
  };
}
