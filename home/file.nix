{
  config,
  myPkgs,
  ...
}:
{
  home.packages = with myPkgs; [ 
    wallpaper 
    wanxiang_base
    wanxiang_pram
    ];

  home.file = {
    nix-profile = {
      source = config.home.path;
      target = ".nix-profile";
    };

    wanxiang_base = {
      source = "${myPkgs.rime.wanxiang_base}/share/fcitx5/rime";
      target = ".local/share/fcitx5/rime";
    };

    wanxiang_pram = {
      source = "${myPkgs.rime.wanxiang_pram}/share/fcitx5/rime/wanxiang-lts-zh-hans.gram";
      target = ".local/share/fcitx5/rime/wanxiang-lts-zh-hans.gram";
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
