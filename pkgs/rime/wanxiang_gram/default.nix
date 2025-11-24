{ stdenv, sources, fetchurl }:

stdenv.mkDerivation rec {
  pname = "wanxiang_gram";
  version = "LTS";

  src = fetchurl {
    url = "https://github.com/amzxyz/RIME-LMDG/releases/download/LTS/wanxiang-lts-zh-hans.gram";
    sha256 = "sha256:40434c92d84ed52168e921ced47aa86e4b4009db5dfe659f98f8d07e5b36e324";
    name = "wanxiang-lts-zh-hans.gram";
  };

  dontBuild = true;
  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/share/fcitx5/rime
    cp $src $out/share/fcitx5/rime/wanxiang-lts-zh-hans.gram
  '';
}