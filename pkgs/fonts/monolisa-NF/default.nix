{ stdenv, sources }:

stdenv.mkDerivation rec {
  pname = monolisa-NF;
  version = "1.0.0";
  
  src = sources.monolisa-NF.src;

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    cp -r * $out/share/fonts/truetype/
  '';
}