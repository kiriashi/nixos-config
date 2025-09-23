{ stdenv, sources }:

stdenv.mkDerivation rec {
  pname = "wanxiang_gram";
  version = "1.0.0";
  
  src = sources.wanxiang_gram.src;

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/share/fcitx5/rime
    cp -r ${src}/* $out/share/fcitx5/rime/
  '';
}