{
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    fastfetch
    git
    uv
    jq
    gcc
    nvfetcher
    nix-output-monitor
    wlr-randr
    xorg.xrandr

    unzip
    unrar
    p7zip

    bibata-cursors
    adwaita-icon-theme

    gnumake
    gcc
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

  environment.localBinInPath = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    EDITOR = "hx";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
  };
}
