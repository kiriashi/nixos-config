{ pkgs }:
let
  sources = import ./_sources/generated.nix {
    inherit (pkgs) fetchgit fetchurl fetchFromGitHub dockerTools;
  };

  loadDir = dir: extraArgs: pkgs.callPackage dir extraArgs;

  loadSubdirs = baseDir: extraArgs:
    let
      entries = builtins.readDir baseDir;
      isDir = name: entries.${name} == "directory";
      dirNames = builtins.filter isDir (builtins.attrNames entries);
    in
    builtins.listToAttrs (builtins.map (name: {
      inherit name;
      value = loadDir (baseDir + "/${name}") extraArgs;
    }) dirNames);
in
{
  wallpaper = loadDir ./wallpaper { inherit sources; };

  rime = loadSubdirs ./rime { inherit sources; };
  Themes = loadSubdirs ./Themes {};
}