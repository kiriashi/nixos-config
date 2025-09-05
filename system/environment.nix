{ 
  pkgs, 
  ... 
}:

{
  environment.systemPackages = with pkgs; [
    fastfetch
    git
    uv
    gcc
    nix-output-monitor
    wlr-randr
    xrog.xrandr

    unzip
    unrar
    p7zip

    bibata-cursors
    adwaita-icon-theme

    # openwrt编译环境
    ack antlr3 asciidoc autoconf automake
    binutils bison bzip2 
    ccache clang cmake cpio curl cdrtools
    dtc
    ecj
    fastjar flex fuse fuse3
    gawk gettext gnutls gperf gmp
    haveged help2man
    intltool
    libelf libglibutil libtool libmpc lld libllvm libyaml
    mpfr msmtp
    ncurses ninja
    openssl
    python313Packages.ply python313Packages.docutils python313Packages.pyelftools pkgconf
    qemu-utils
    re2c rsync readline
    scons squashfs-tools-ng subversion
    swig
    texinfo tinyxxd
    uglify-js upx
    vim
    wget
    xmlto 
    zlib zstd
  ];

  environment.localBinInPath = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    EDITOR = "hx";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
  };
}
