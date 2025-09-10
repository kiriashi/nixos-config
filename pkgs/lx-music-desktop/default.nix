{ stdenv
, lib
, appimageTools
, sources
, makeDesktopItem
}:

let
  pname = "lx-music-desktop";
  version = sources.lx-music-desktop.version;
  src = sources.lx-music-desktop.src;

  extracted = appimageTools.extractType2 {
    inherit pname version src;
  };

  desktopItem = makeDesktopItem {
    name = pname;
    exec = pname;
    icon = pname;
    comment = "A free and open-source music player";
    desktopName = "LX Music";
    categories = [ "Audio" "Music" ];
  };

in stdenv.mkDerivation {
  inherit pname version src;

  nativeBuildInputs = [ appimageTools ];

  installPhase = ''
    # 创建目录结构
    mkdir -p $out/bin
    mkdir -p $out/share/applications
    mkdir -p $out/share/icons/hicolor/512x512/apps
    
    # 安装 AppImage
    install -Dm755 $src $out/bin/${pname}
    chmod +x $out/bin/${pname}
    
    # 安装桌面文件
    cp ${desktopItem}/share/applications/* $out/share/applications
    
    # 复制图标
    cp ${extracted}/usr/share/icons/hicolor/512x512/apps/lx-music-desktop.png $out/share/icons/hicolor/512x512/apps/${pname}.png
  '';

  meta = with lib; {
    description = "A free and open-source music player";
    homepage = "https://github.com/lyswhut/lx-music-desktop";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = [ "x86_64-linux" ];
  };
}