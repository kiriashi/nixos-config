{ pkgs, ... }:
{
  imports = [ ./default.nix ];

  profile = {
    editor = "hx";
    font = "Maple Mono NF CN";
  };

  optional = {
    wm = true;
    hypr = {
      enable = false;
    };
    niri = true;

    vir = true;

    dev = {
      helix = true;
      zed = true;
      vscode = true;

      node = true;
    };
  };

}