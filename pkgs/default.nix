{ pkgs }:

let
  sources = import ./_sources/generated.nix;

  loadDir = dir: extraArgs: pkgs.callPackage dir extraArgs;
  
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
  wallpapers = loadDir ./wallpapers { inherit sources; };
  
  Themes = loadSubdirs ./Themes;
}
