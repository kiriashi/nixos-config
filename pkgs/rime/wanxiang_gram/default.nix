{ stdenv, sources, fetchurl }:

stdenv.mkDerivation rec {
  pname = "wanxiang_gram";
  version = "LTS";

  src = fetchurl {
    url = "https://github.com/amzxyz/RIME-LMDG/releases/download/LTS/wanxiang-lts-zh-hans.gram";
    sha256 = "sha256:c0cafe324f714812ff89f77f0ff77ce7241792a0dffcf28188e3deaee43127bc";
    name = "wanxiang-lts-zh-hans.gram";
  };

  dontBuild = true;
  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/share/fcitx5/rime
    cp $src $out/share/fcitx5/rime/wanxiang-lts-zh-hans.gram
  '';
}