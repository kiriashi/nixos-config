{ ... }:

{
  imports = [
    ./profile/default.nix
    ../hosts/laptop/hardware.nix
    ../hosts/laptop/hardware-configuration.nix
  ];

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