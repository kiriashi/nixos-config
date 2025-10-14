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
    ./services
    ./sops-nix
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
  };
}
