{ stdenv, sources, fetchurl, makeWrapper, lib }:

stdenv.mkDerivation rec {
  pname = "tableplus";
  version = "sources.tableplus.version";

  src = sources.tableplus.src;

  dontBuild = true;

  dontUnpack = true;

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    mkdir -p $out/bin $out/share/tableplus/
    cp $src $out/share/tableplus/tableplus.AppImage
    chmod +x $out/share/tableplus/tableplus.AppImage
    makeWrapper "$out/share/tableplus/tableplus.AppImage" "$out/bin/tableplus"
  '';

  meta = with lib; {
    description = "Modern, native, and friendly GUI tool for relational databases.";
    homepage = "https://tableplus.com/";
    license = licenses.unfree;
    platforms = platforms.x86_64-linux;
  };
}