{ stdenv }:

stdenv.mkDerivation rec {
  pname = "arknights-grub-theme";
  version = "1.0.0";

  src =./Arknights;

  dontBuild = true;

  installPhase = ''
    mkdir -p $out
    cp -r $src/* $out/
  '';
}

