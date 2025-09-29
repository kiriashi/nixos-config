{ stdenv, sources, fetchurl, makeWrapper, desktop-file-utils }:

stdenv.mkDerivation rec {
  pname = "tableplus";
  version = sources.tableplus.version;

  srcs = sources.tableplus.src ./tableplus-120x120.png;

  dontBuild = true;
  dontUnpack = true;

  nativeBuildInputs = [ makeWrapper desktop-file-utils ]; 

  installPhase = ''
    mkdir -p $out/bin $out/share/tableplus/ $out/share/applications/
    cp $srcs/tableplus.AppImage $out/share/tableplus/tableplus.AppImage
    cp $srcs/tableplus-120x120.png $out/share/applications/tableplus-120x120.png
    chmod +x $out/share/tableplus/tableplus.AppImage

    cat > $out/share/applications/tableplus.desktop << EOF
    [Desktop Entry]
    Name=TablePlus
    Comment=Modern, native, and friendly GUI tool for relational databases.
    Exec=$out/bin/tableplus
    Icon=$out/share/applications/tableplus-120x120.png
    Terminal=false
    Type=Application
    Categories=Development;Database;
    EOF

    makeWrapper "$out/share/tableplus/tableplus.AppImage" "$out/bin/tableplus"
    
    fixupPhase
  '';
}