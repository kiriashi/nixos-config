{ stdenv, sources }:

stdenv.mkDerivation rec {
  pname = "wallpaper";
  version = "1.0.0";
  
  src = sources.wallpaper.src;

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/share/wallpapers
    cp -r * $out/share/wallpapers/
  '';
}