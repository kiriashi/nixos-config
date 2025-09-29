{ pkgs, ... }:
{
  imports = [
    ./go.nix
    ./java.nix
    ./php.nix
    ./lua.nix
    ./rust.nix
    ./node.nix
    ./python.nix
  ];

  home.packages = with pkgs; [
    # nil
    nixpkgs-fmt
    nixfmt-rfc-style
    nil
    nixd

    # markdown
    marksman
    markdownlint-cli
    markdownlint-cli2
    markdown-oxide

    # lua
    lua-language-server
    stylua

    # typst
    typstfmt
    tinymist

    # json
    vscode-langservers-extracted

    # build tools
    shellcheck
    gcc
    gnumake
    pkg-config
  ];
}