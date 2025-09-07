{ stdenv }:

stdenv.mkDerivation rec {
  pname = "Arknights";
  version = "1.0";

  src =./theme-files;

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/
    cp -r $src/* $out/
  '';
}

