{ lib, config, pkgs, ... }:

lib.mkIf config.optional.dev.php {
  programs.php = {
    enable = true;
    package = pkgs.php83;
  };

  home.packages = with pkgs; [
    composer
    php83Packages.phpstan
    php83Packages.psalm
    vscode-extensions.xdebug.php-debug
    vscode-extensions.bmewburn.vscode-intelephense-client
  ];
}