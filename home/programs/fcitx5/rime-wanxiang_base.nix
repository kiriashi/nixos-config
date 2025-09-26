{
  config,
  myPkgs,
  ...
}:
{
  home.packages = with myPkgs; [ 
    rime.wanxiang_base
    rime.wanxiang_gram 
    ];
    
  home.file = {
    wanxiang_base = {
      source = "${myPkgs.rime.wanxiang_base}/share/fcitx5/rime";
      target = ".local/share/fcitx5/rime";
      recursive = true;
    };

    wanxiang_pram = {
      source = "${myPkgs.rime.wanxiang_gram}/share/fcitx5/rime/wanxiang-lts-zh-hans.gram";
      target = ".local/share/fcitx5/rime/wanxiang-lts-zh-hans.gram";
    };
  };
}
