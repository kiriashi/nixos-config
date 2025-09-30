{ stdenv, sources, fetchurl, makeWrapper, desktop-file-utils }:

stdenv.mkDerivation rec {
  pname = "tableplus";
  version = sources.tableplus.version;

  src = sources.tableplus.src;

  icon = ./tableplus-120x120.png;

  dontBuild = true;
  dontUnpack = true;

  nativeBuildInputs = [ makeWrapper desktop-file-utils ];

  installPhase = ''
    mkdir -p $out/bin \
             $out/share/tableplus/ \
             $out/share/applications/ \
             $out/share/icons/hicolor/120x120/apps

    cp $src $out/share/tableplus/tableplus.AppImage
    chmod +x $out/share/tableplus/tableplus.AppImage

    cp ${icon} $out/share/icons/hicolor/120x120/apps/tableplus.png

    cat > $out/share/applications/tableplus.desktop << EOF
    [Desktop Entry]
    Name=TablePlus
    Comment=Modern, native, and friendly GUI tool for relational databases.
    Exec=$out/bin/tableplus %U
    Icon=tableplus
    Terminal=false
    Type=Application
    Categories=Development;Database;
    EOF

    makeWrapper "$out/share/tableplus/tableplus.AppImage" "$out/bin/tableplus"

    update-desktop-database -q $out/share/applications
  '';
}