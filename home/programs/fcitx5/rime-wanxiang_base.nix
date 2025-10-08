{
  config,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [ 
    self.rime.wanxiang_base
    self.rime.wanxiang_gram 
    ];
    
  home.file = {
    wanxiang_base = {
      source = "${pkgs.self.rime.wanxiang_base}/share/fcitx5/rime";
      target = ".local/share/fcitx5/rime";
      recursive = true;
    };

    wanxiang_pram = {
      source = "${pkgs.self.rime.wanxiang_gram}/share/fcitx5/rime/wanxiang-lts-zh-hans.gram";
      target = ".local/share/fcitx5/rime/wanxiang-lts-zh-hans.gram";
    };
  };
}
