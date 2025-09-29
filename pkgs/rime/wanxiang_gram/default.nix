{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  pname = "wanxiang_gram";
  version = "LTS";

  src = fetchurl {
    url = "https://github.com/amzxyz/RIME-LMDG/releases/download/LTS/wanxiang-lts-zh-hans.gram";
    sha256 = "sha256:6ced3a60ede57ddbd698c4eafc5219977551296c670d52d34d59bde7c19fb66d";
    name = "wanxiang-lts-zh-hans.gram";
  };

  dontBuild = true;
  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/share/fcitx5/rime
    cp $src $out/share/fcitx5/rime/wanxiang-lts-zh-hans.gram
  '';
}