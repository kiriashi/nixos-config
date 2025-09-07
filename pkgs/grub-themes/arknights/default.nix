{ stdenv, lib }:

stdenv.mkDerivation rec {
  pname = "arknights";
  version = "1.0";

  src =./theme-files;

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/
    cp -r $src/* $out/
  '';
}

