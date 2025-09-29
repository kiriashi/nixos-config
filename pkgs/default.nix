{ pkgs }:
let
  sources = import ./_sources/generated.nix {
    inherit (pkgs) fetchgit fetchurl fetchFromGitHub dockerTools;
  };

  loadDir = dir: pkgs.callPackage dir { inherit sources; };

  loadSubdirs = baseDir:
    let
      entries = builtins.readDir baseDir;
      isDir = name: entries.${name} == "directory";
      dirNames = builtins.filter isDir (builtins.attrNames entries);
    in
    builtins.listToAttrs (builtins.map (name: {
      inherit name;
      value = loadDir (baseDir + "/${name}");
    }) dirNames);
in
{
  wallpapers = loadDir ./wallpapers;

  grub-themes = loadSubdirs ./grub-themes;
  fonts = loadSubdirs ./fonts;
  rime = loadSubdirs ./rime;
}