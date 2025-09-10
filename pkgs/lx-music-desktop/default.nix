# pkgs/lx-music-desktop/default.nix
{ 
stdenv, 
appimageTools, 
makeDesktopItem,
sources
}:

let
  pname = "lx-music-desktop";
  version = sources.lx-music-desktop.version;
  
  src = sources.lx-music-desktop.src;

  desktopItem = makeDesktopItem {
    name = pname;
    exec = pname;
    icon = pname;
    comment = "A free and open-source music player";
    desktopName = "LX Music";
    categories = [ "Audio" "Music" ];
  };

in stdenv.mkDerivation rec {
  inherit pname version src;

  nativeBuildInputs = [ appimageTools ];

  installPhase = ''
    # 创建应用目录
    mkdir -p $out/bin
    mkdir -p $out/share/applications
    mkdir -p $out/share/icons/hicolor/512x512/apps
    
    # 安装 AppImage
    install -Dm755 $src $out/bin/${pname}
    chmod +x $out/bin/${pname}
    
    # 安装桌面文件
    cp ${desktopItem}/share/applications/* $out/share/applications
    
    # 提取图标
    ${appimageTools.wrapType2 {
      name = pname;
      src = src;
      extraPkgs = pkgs: [];
    }}/bin/${pname} --appimage-extract
    cp squashfs-root/usr/share/icons/hicolor/512x512/apps/lx-music-desktop.png $out/share/icons/hicolor/512x512/apps/${pname}.png
  '';

  meta = with stdenv.lib; {
    description = "A free and open-source music player";
    homepage = "https://github.com/lyswhut/lx-music-desktop";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = [ "x86_64-linux" ];
  };
}