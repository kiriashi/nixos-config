{ stdenv, sources }:

stdenv.mkDerivation rec {
  pname = wallpapers;
  version = "1.0.0";
  
  src = sources.wallpapers.src;

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/share/wallpapers
    cp -r * $out/share/wallpapers/
  '';
}