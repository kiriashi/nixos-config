{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation {
  pname = "wallpapers";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "kiriashi";
    repo = "wallpaper";
    rev = "main";
    sha256 = "sha256-sMC6FM1IZ3v9JVYR5Ed48w1oOa/d0cvRmH6wp+7TXLY=";
  };

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/share/wallpapers
    cp -r * $out/share/wallpapers/
  '';
}