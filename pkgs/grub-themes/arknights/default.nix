{ stdenv }:

stdenv.mkDerivation rec {
  pname = "arknights";
  version = "1.0";

  src =./theme-files;

  installPhase = ''
    mkdir -p $out/share/grub/themes/Arknights
    cp -r $src/* $out/share/grub/themes/Arknights/
  '';
}
