{ stdenv, sources, fcitx5 }:

stdenv.mkDerivation rec {
  pname = "wanxiang_base";
  version = sources.wanxiang_base.version;
  
  src = sources.wanxiang_base.src;

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/share/fcitx5/rime
    cp -r ${src}/* $out/share/fcitx5/rime/
  '';
}