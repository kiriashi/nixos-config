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

    rime-config = {
      source = ../home/fcitx5/rime;
      target = ".local/share/fcitx5/rime";
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
