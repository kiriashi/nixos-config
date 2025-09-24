{ stdenv, sources, fetchurl }:

stdenv.mkDerivation rec {
  pname = "wanxiang_gram";
  version = sources.wanxiang_gram.version;
  
  src = fetchurl {
    url = "https://github.com/amzxyz/RIME-LMDG/releases/download/LTS/wanxiang-lts-zh-hans.gram";
    sha256 = "sha256-yFOtlP4vsFkj3jMeuQwIH/PuH3nScsODlawW35Nq3EA=";
  };

  dontBuild = true;
  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/share/fcitx5/rime
    cp -r ${src} $out/share/fcitx5/rime/wanxiang-lts-zh-hans.gram
  '';
}