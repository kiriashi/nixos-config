{ stdenv, sources }:

stdenv.mkDerivation rec {
  pname = Monaco-NF;
  version = "1.0.0";
  
  src = sources.Monaco-NF.src;

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/share/fonts/truetype
    cp -r * $out/share/fonts/truetype/
  '';
}