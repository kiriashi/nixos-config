{ stdenv }:

stdenv.mkDerivation rec {
  pname = "grub";
  version = "1.0";

  src =./Arknights;

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/
    cp -r $src/* $out/
  '';
}

