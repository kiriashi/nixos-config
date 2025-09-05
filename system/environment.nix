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

    unzip
    unrar
    p7zip

    bibata-cursors
    adwaita-icon-theme

    # openwrt编译环境
    ack antlr3 asciidoc autoconf automake autopoint
    binutils bison bzip2 
    ccache clang cmake cpio curl
    device-tree-compiler
    ecj
    fastjar flex fuse fuse3
    gawk gettext gnutls gperf gmp
    haveged help2man
    intltool
    libelf libglib2 libtool libmpc lld llvm libyaml
    mpfr mkisofs msmtp
    ncurses ninja
    openssl
    python3Packages.ply python3Packages.docutils python3Packages.pyelftools pkgconf
    qemu
    re2c rsync readline
    scons squashfs-tools subversion
    swig
    texinfo
    uglify-js upx
    vim
    wget
    xmlto xxd
    zlib zstd
  ];

  environment.localBinInPath = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    EDITOR = "hx";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
  };
}
