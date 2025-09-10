{
  sources,
  appimageTools,
  ...
}:
let
  pname = sources.lx-music-desktop.pname;
  version = sources.lx-music-desktop.version;
  src = sources.lx-music-desktop.src;
in
appimageTools.wrapType2 {
  inherit pname version src;
}