{ stdenv, sources, fetchurl }:

stdenv.mkDerivation rec {
  pname = "wanxiang_gram";
  version = sources.wanxiang_gram.version;
  
  src = sources.wanxiang_gram.src;

  dontBuild = true;
  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/share/fcitx5/rime
    cp -r ${src} $out/share/fcitx5/rime/wanxiang-lts-zh-hans.gram
  '';
}