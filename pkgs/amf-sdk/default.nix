{ stdenv, sources }:

stdenv.mkDerivation rec {
  pname = sources.amf-sdk.pname;
  version = sources.amf-sdk.version;
  
  src = sources.amf-sdk.src;

  dontBuild = true;

  installPhase = ''
    mkdir -p $out
    cp -r include $out
    cp -r lib $out
  '';
}