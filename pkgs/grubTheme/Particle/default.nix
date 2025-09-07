{ stdenv }:

stdenv.mkDerivation rec {
  pname = "Particle";
  version = "1.0";

  src =./theme-files;

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/
    cp -r $src/* $out/
  '';
}

