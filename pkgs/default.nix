{ pkgs }:
let
  sources = import ./_sources/generated.nix {
    inherit (pkgs) fetchgit fetchurl fetchFromGitHub dockerTools;
  };

  coreLoadDir = dir: pkgs.callPackage dir { inherit sources; };

  processDirs = dirList:
    builtins.listToAttrs (builtins.map (dirPath: {
      name = builtins.baseNameOf dirPath;
      value = coreLoadDir dirPath;
    }) dirList);

  processSubdirs = dirList:
    builtins.listToAttrs (builtins.map (baseDir: {
      name = builtins.baseNameOf baseDir;
      value = 
        let
          entries = builtins.readDir baseDir;
          isDir = name: entries.${name} == "directory";
          dirNames = builtins.filter isDir (builtins.attrNames entries);
        in
        builtins.listToAttrs (builtins.map (name: {
          inherit name;
          value = coreLoadDir (baseDir + "/${name}");
        }) dirNames);
    }) dirList);

  combineOutput = { loadDir, loadSubdirs }:
    (processDirs loadDir) // (processSubdirs loadSubdirs);
in
combineOutput {
  # 直接加载的目录
  loadDir = [
    ./arknights-grub-theme
    ./wallpapers
  ];
  
  # 加载子目录的目录
  loadSubdirs = [
    ./fonts
    ./rime
  ];
}