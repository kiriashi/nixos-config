{ lib, config, pkgs, ... }:

lib.mkIf config.optional.dev.java {
  programs.java = {
    enable = true;
    package = pkgs.jdk17;
  };

  home.packages = with pkgs; [
    maven
    gradle
    vscode-extensions.redhat.java
    vscode-extensions.vscjava.vscode-java-test
    vscode-extensions.vscjava.vscode-maven
  ];
}