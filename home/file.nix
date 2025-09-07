{
  config,
  ...
}:
{
  home.file = {
    nix-profile = {
      source = config.home.path;
      target = ".nix-profile";
    };

    rime-config1 = {
      source = ../home/fcitx5/rime/wanxiang-update.sh;
      target = ".local/share/fcitx5/rime/wanxiang-update.sh";
    };

    rime-config2 = {
      source = ../home/fcitx5/rime/user_exclude_file.txt;
      target = ".local/share/fcitx5/rime/custom/user_exclude_file.txt";
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
