{
  lib,
  pkgs,
  config,
  ...
}:

{
  imports = [
    ../home/clipboard-sync.nix
    ../home/dconf.nix
    ../home/dotfiles.nix
    ../home/file.nix
    ../home/fonts.nix
    ../home/programs.nix
    ../home/theme.nix
    ../home/wm-related.nix
    ../home/xdg.nix
  ];

  programs.home-manager.enable = true;

  home = {
    username = "${config.profile.userName}";
    homeDirectory = "/home/${config.profile.userName}";
    stateVersion = "25.11";
    shell.enableFishIntegration = true;
    preferXdgDirectories = true;

    activation.installPackages = {
      data = lib.mkForce "";
      before = lib.mkForce [ ];
      after = lib.mkForce [ ];
    };
  };

}
