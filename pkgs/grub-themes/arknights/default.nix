{ stdenv }:

stdenv.mkDerivation rec {
  pname = "arknights";
  version = "1.0";

  src =./theme-files;

  installPhase = ''
    mkdir -p $out/share/grub/themes/${pname}
    cp -r $src/* $out/share/grub/themes/${pname}/

    chmod -R a+r $out/share/grub/themes/${pname}
    find $out/share/grub/themes/${pname} -type d -exec chmod a+x {} \;
  '';
}
