{
  lib,
  pkgs,
  config,
  ...
}:

{
  imports = [
    ./editors
    ./programs
    ./wm
  ];

  programs.home-manager.enable = true;

  home = {
    username = config.profile.userName;
    homeDirectory = "/home/${config.profile.userName}";
    stateVersion = "25.11";
    shell.enableFishIntegration = true;
    preferXdgDirectories = true;

    activation.installPackages = {
      data = lib.mkForce "";
      before = lib.mkForce [ ];
      after = lib.mkForce [ ];
    };

    file = {
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
  };
  
  xdg = {
    enable = true;
    userDirs.enable = true;
    userDirs.createDirectories = true;

    desktopEntries = {
      qq = {
        name = "QQ";
        exec = "${pkgs.qq}/bin/qq --enable-wayland-ime --wayland-text-input-version=3 %U";
        icon = "${pkgs.qq}/share/icons/hicolor/512x512/apps/qq.png";
        categories = [ "Network" ];
        comment = "轻松做自己";
      };

      mcaselector = {
        name = "mcaselector";
        exec = "mcaselector";
      };
    };
  };
}
