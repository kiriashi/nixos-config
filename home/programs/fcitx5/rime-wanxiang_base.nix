{
  config,
  selfPkgs,
  ...
}:
{
  home.packages = with selfPkgs; [ 
    rime.wanxiang_base
    rime.wanxiang_gram 
    ];
    
  home.file = {
    wanxiang_base = {
      source = "${selfPkgs.rime.wanxiang_base}/share/fcitx5/rime";
      target = ".local/share/fcitx5/rime";
      recursive = true;
    };

    wanxiang_pram = {
      source = "${selfPkgs.rime.wanxiang_gram}/share/fcitx5/rime/wanxiang-lts-zh-hans.gram";
      target = ".local/share/fcitx5/rime/wanxiang-lts-zh-hans.gram";
    };
  };
}
