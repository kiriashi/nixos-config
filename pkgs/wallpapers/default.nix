# pkgs/wallpapers/default.nix
{ stdenv, fetchFromGitHub, sources, }:

stdenv.mkDerivation rec {
  pname = "wallpapers";
  version = "1.0.0";
  
  src = fetchFromGitHub {
    inherit (sources.wallpaper.src) owner repo rev sha256;
  };

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/share/wallpapers
    cp -r * $out/share/wallpapers/
  '';
}