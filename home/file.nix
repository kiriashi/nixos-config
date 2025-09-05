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
