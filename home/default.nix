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
    ./secrets
    ./wm
  ];

  programs.home-manager.enable = true;

  home = {
    username = config.profile.userName;
    homeDirectory = config.profile.homeDir;
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
      nautilus = {
        name = "Files";
        comment = "Browse and organize files";
        exec = "bash -c 'GTK_IM_MODULE=\"fcitx\" exec ${pkgs.gnome.nautilus}/bin/nautilus %U'";
        icon = "org.gnome.Nautilus";
        categories = [ "System" "Utility" "Core" ];
        terminal = false;
      };
    };
  };
}
