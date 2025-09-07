{ stdenv, lib }:

stdenv.mkDerivation rec {
  pname = "arknights";
  version = "1.0";

  src =./theme-files;

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/share/grub/themes/Arknights
    cp -r $src/* $out/share/grub/themes/Arknights/
    ln -s $out/share/grub/themes/Arknights/theme.txt $out/theme.txt
  '';

  passthru.grubTheme = "${placeholder "out"}/share/grub/themes/Arknights/theme.txt";
}

