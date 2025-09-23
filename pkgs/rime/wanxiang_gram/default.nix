{ stdenv, sources }:

stdenv.mkDerivation rec {
  pname = "wanxiang_gram";
  version = "1.0.0";
  
  src = sources.wanxiang_gram.src;

  installPhase = ''
    mkdir -p $out/share/fcitx5/rime
    cp -r * $out/share/fcitx5/rime/
  '';
}