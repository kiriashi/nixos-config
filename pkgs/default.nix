{ pkgs }:
let
  sources = import ./_sources/generated.nix {
    inherit (pkgs) fetchgit fetchurl fetchFromGitHub dockerTools;
  };
  
  loadDir = dir: extraArgs: pkgs.callPackage dir extraArgs;
  
  loadSubdirs = baseDir:
    let
      entries = builtins.readDir baseDir;
      isDir = name: entries.${name} == "directory";
      dirNames = builtins.filter isDir (builtins.attrNames entries);
    in
    builtins.listToAttrs (builtins.map (name: {
      inherit name;
      value = loadDir (baseDir + "/${name}") {};
    }) dirNames);
in
{
  wallpaper = loadDir ./wallpaper { inherit sources; };
  scx_rust = loadDir ./scx_rust { inherit sources; };

  Themes = loadSubdirs ./Themes;
}