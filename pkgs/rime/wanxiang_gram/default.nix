{ stdenv, sources, fetchurl }:

stdenv.mkDerivation rec {
  pname = "wanxiang_gram";
  version = "LTS";

  src = fetchurl {
    url = "https://github.com/amzxyz/RIME-LMDG/releases/download/LTS/wanxiang-lts-zh-hans.gram";
    sha256 = "sha256:307c6274f5dbcc2f0132e99a5e781fe168ab909d7abed7ba495594b665f6f3b1";
    name = "wanxiang-lts-zh-hans.gram";
  };

  dontBuild = true;
  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/share/fcitx5/rime
    cp $src $out/share/fcitx5/rime/wanxiang-lts-zh-hans.gram
  '';
}