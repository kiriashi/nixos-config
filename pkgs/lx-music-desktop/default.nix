{ lib, stdenv, makeWrapper, lx-music-desktop }:

stdenv.mkDerivation {
  pname = "lx-music-desktop";
  version = 2.11.0;

  nativeBuildInputs = [ makeWrapper ];

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin
    makeWrapper ${lx-music-desktop}/bin/lx-music-desktop $out/bin/lx-music-desktop \
      --set ELECTRON_LOG_APP_NAME "LX Music" \
      --set XDG_CONFIG_HOME "$HOME/.config"
  '';

  meta = with lib; {
    description = "LX Music desktop client with fixed config/log paths";
    homepage = "https://github.com/lyswhut/lx-music-desktop";
    license = licenses.mit;
    platforms = platforms.linux;
  };
}