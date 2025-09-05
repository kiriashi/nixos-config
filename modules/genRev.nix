{ self, ... }:

{
  system.configurationRevision = self.rev or null;

  system.nixos.label = let
    date = self.sourceInfo.lastModifiedDate or "";
    shortRev = self.sourceInfo.shortRev or "";
  in
    if date != "" && shortRev != ""
    then "${builtins.substring 0 8 date}.${shortRev}"
    else "dirty";
}
