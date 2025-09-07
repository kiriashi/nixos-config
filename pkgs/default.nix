{ pkgs }:

let
  loadDir = dir: pkgs.callPackage dir {};
  
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
  # 直接包
  # my-app = loadDir ./my-app;
  
  # 分类包
  grubTheme = loadSubdirs ./grubTheme;
}
