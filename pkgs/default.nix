{ pkgs }:
let
  sources = import ./_sources/generated.nix {
    inherit (pkgs) fetchgit fetchurl fetchFromGitHub dockerTools;
  };

  loadDir = dir: pkgs.callPackage dir { sources = sources; };

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
  wallpaper = loadDir ./wallpaper;

  rime = loadSubdirs ./rime;
  Themes = loadSubdirs ./Themes;
}