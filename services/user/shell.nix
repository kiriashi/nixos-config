{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "openwrt-build-env";

  buildInputs = with pkgs; [
    gnumake
    gcc
    g++
    binutils
    gawk
    flex
    bison
    gettext
    unzip
    zip
    zlib
    file
    openssl
    wget
    curl
    python3
    python3Packages.setuptools
    python3Packages.wheel
    rsync
    git
    patch
    ncurses
    ncurses.dev
  ];

  shellHook = ''
    export PYTHONPATH=${pkgs.python3.sitePackages}
  '';
}