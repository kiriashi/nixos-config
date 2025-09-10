{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation {
  pname = "wallpapers";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "kiriashi";
    repo = "wallpaper";
    rev = "main";
    sha256 = "sha256-vrrnRmV3h5CkU7fCdSQMQw5fU9C4cBX9AWmOu5ieOdQ=";
  };

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/share/wallpapers
    cp -r * $out/share/wallpapers/
  '';
}