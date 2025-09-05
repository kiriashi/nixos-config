{
  lib,
  ...
}:

{
  imports = [
    ../home/dconf.nix
    ../home/dotfiles.nix
    ../home/file.nix
    ../home/fonts.nix
    ../home/git.nix
    ../home/programs.nix
    ../home/theme.nix
    ../home/wm-related.nix
    ../home/xdg.nix
  ];

  programs.home-manager.enable = true;

  home = {
    username = "kiriashi";
    homeDirectory = "/home/kiriashi";
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
