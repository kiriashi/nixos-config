{ stdenv, sources }:

stdenv.mkDerivation rec {
  pname = "Arknights_Theresa";
  version = "1.0.0";

  src = sources.Grub-Theme-Arknights_Theresa.src;

  dontBuild = true;

  installPhase = ''
    mkdir -p $out
    cp -r $src/Arknights_Theresa/* $out/
  '';
}

