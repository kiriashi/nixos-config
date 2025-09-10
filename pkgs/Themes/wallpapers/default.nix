{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation {
  pname = "wallpapers";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "kiriashi";
    repo = "wallpaper";
    rev = "main";
    sha256 = "sha256-oybEygCP8bbsRR/8pasPpL0WkU5u++GsiwkpbbEMpNg=";
  };

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/share/wallpapers
    cp -r * $out/share/wallpapers/
  '';
}