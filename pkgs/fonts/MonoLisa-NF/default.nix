{ stdenv, sources }:

stdenv.mkDerivation rec {
  pname = MonoLisa-NF;
  version = "1.0.0";
  
  src = sources.MonoLisa-NF.src;

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    cp -r * $out/share/fonts/truetype/
  '';
}