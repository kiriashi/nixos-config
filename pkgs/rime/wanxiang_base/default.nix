{ stdenv, sources, unzip }:

stdenv.mkDerivation rec {
  pname = "wanxiang_base";
  version = "LTS";
  
  src = sources.wanxiang_base.src;

  buildInputs = [ unzip ];

  unpackPhase = ''
    unzip ${src} -d $PWD
  '';

  installPhase = ''
    mkdir -p $out/share/fcitx5/rime
    cp -r $PWD/* $out/share/fcitx5/rime/
  '';
}